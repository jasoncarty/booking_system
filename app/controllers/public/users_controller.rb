class Public::UsersController < PublicController

  skip_before_action :authorize, only: [:verify, :verification]

  # GET /users/verify/:token
  def verify
    session[:user_id] = nil
  end

  # GET /users/:id/
  def edit
    @user = User.find(params[:id])
  end

  # POST /users/:id/
  def update
    @user = User.find(current_user.id)
    @user.validate_password = false if params[:user][:password].blank?
    if @user.update(user_params)
      flash[:notice] = 'Changed saved'
      redirect_to root_path
    else
      render :edit
    end
  end

  # POST /users/verification/
  def verification
    @user = User.find_by_verification_token(params[:verification_token])
    @token = params[:verification_token]

    if !@user
      @error = 'Verification token is invalid'
      render :verify
      return
    end

    message = @user.confirmed_at.present? ?
      "Your account has already been verified" :
      "Your account has now been verified"

    if @user.update(user_params)
      @user.confirm
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:notice] = message
    else
      @errors = @user.errors
      render :verify
    end

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

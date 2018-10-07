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
    if @user
      if @user.confirmed_at.present?
        session[:user_id] = @user.id
        redirect_to root_path
        flash[:notice] = "Your account has already been verified"
      else

        if @user.update(user_params)
          @user.confirmed_at = Time.now
          @user.validate_password = false
          @user.save
          session[:user_id] = @user.id
          redirect_to root_path
          flash[:notice] = "Your account has now been verified"
        else
          @errors = @user.errors
          render :verify
        end
      end
    else
      @error = 'Verification token is invalid'
      render :verify
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

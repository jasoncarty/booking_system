class Admin::UsersController < AdminController

  layout false, only: :destroy

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.validate_password = false
    if @user.save
      flash[:notice] = 'Changes saved'
      redirect_to admin_users_path
      UserMailer.new_user(@user, sitename).deliver_now
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.validate_password = false
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    if @user.destroy
      @result = 'success'
    else
      @result = @user.errors.messages
    end
    @result
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end

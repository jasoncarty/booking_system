class PasswordsController < ApplicationController

  def new
  end

  def create
    @user = User.where(email: params[:email]).first
    if @user
      if @user.confirmed_at.nil?
        flash[:alert] = "Your account has not been confirmed yet."
        redirect_to login_path
      else
        @user.validate_password = false
        @user.add_password_token
        @user.save
        flash[:notice] = "An email has been sent to you with instructions."
        redirect_back(fallback_location: login_path)
        UserMailer.password_reset(@user, sitename).deliver_now
      end
    else
      flash[:alert] = "Email address not found in system"
      redirect_back(fallback_location: login_path)
    end
  end

  def reset
  end

  def update
    @user = User.where(password_reset_token: params[:password_reset_token]).first
    if @user
      @user.password = params[:password]
      if params[:password] == params[:password_confirmation]
        @user.update(password: params[:password])
        flash[:notice] = 'Your password has been updated.'
        redirect_back(fallback_location: login_path)
      else
        flash[:alert] = "Password does not match password confirmation."
        redirect_back(fallback_location: login_path)
      end
    else
      flash[:alert] = "The token is invalid, please make a new request."
      redirect_to login_path
    end
  end
end
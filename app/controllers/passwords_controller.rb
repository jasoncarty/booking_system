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
        if @user.save
          flash[:notice] = "An email has been sent to you with instructions."
          redirect_to :back
          UserMailer.password_reset(@user, sitename).deliver_now
        else
          flash[:alert] = @user.errors.messages.to_s
          render :new
        end
      end
    else
      flash[:alert] = "Email address not found in system"
      redirect_to :back
    end
  end

  def reset
  end

  def update
    @user = User.where(password_reset_token: params[:password_reset_token]).first
    if @user
      @user.password = params[:password]
      if params[:password] == params[:password_confirmation]
        if @user.update(password: params[:password])
          flash[:notice] = 'Your password has been updated.'
          redirect_to :back
        else
          flash[:alert] = @user.errors.messages.to_s
          render :new
        end
      else
        flash[:alert] = "Password does not match password confirmation."
        redirect_to :back
      end
    else
      flash[:alert] = "The token is invalid, please make a new request."
      redirect_to login_path
    end
  end
end
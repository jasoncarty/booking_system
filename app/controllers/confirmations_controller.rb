class ConfirmationsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      if !@user.confirmed_at.blank?
        flash[:notice] = "Your account has already been confirmed!"
        redirect_to confirmation_new_path
      else
        @user.add_verify_token
        @user.validate_password = false
        @user.save
        UserMailer.new_user(@user, sitename).deliver_now
        flash[:notice] = "An email has been sent to you"
        redirect_to confirmation_new_path
      end
    else
      flash[:alert] = "Email not found in system"
      redirect_to confirmation_new_path
    end
  end

end
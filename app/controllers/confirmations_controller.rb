class ConfirmationsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.add_verify_token
      UserMailer.new_user(@user, sitename).deliver_now
      flash[:notice] = "An email has been sent to you"
      redirect_to confirmation_new_path
    else
      flash[:alert] = "Email not found in system"
      redirect_to confirmation_new_path
    end
  end

end
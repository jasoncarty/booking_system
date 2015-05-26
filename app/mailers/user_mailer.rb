class UserMailer < ApplicationMailer

  def new_user user
    @user = user
    mail to: user.email, subject: "Welcome to the Golf booking system"
  end
end

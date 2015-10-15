class UserMailer < ApplicationMailer

  default from: "noreply@bookingsystem.com"
  def new_user user, sitename
    @user = user
    @sitename = sitename
    mail to: user.email, subject: "Welcome to the #{sitename}"
  end
end

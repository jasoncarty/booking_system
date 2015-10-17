class UserMailer < ApplicationMailer

  default from: "noreply@bookingsystem.com"
  def new_user user, sitename
    @user = user
    @sitename = sitename
    mail to: user.email, subject: "Welcome to the #{sitename}"
  end

  def password_reset user, sitename
    @user = user
    @sitename = sitename
    mail to: user.email, subjet: "New password request for #{sitename}"
  end
end

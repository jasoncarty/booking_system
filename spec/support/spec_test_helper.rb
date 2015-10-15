module SpecTestHelper

  def login_user user
    user = User.find(user.id)
    session[:user_id] = user.id
  end

  def current_user
    current_user ||= User.find(request.session[:user_id])
  end

end
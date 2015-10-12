class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user, :default_maximum_event_attendees, :settings, :sitename

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to login_path unless current_user
  end

  def require_admin
    redirect_to root_path unless current_user.role == 'admin'
  end

  def settings
    @settings ||= SiteSetting.first
  end

  def default_maximum_event_attendees
    settings.maximum_event_attendees
  end

  def sitename
    settings and settings.site_name != "" ? settings.site_name : 'Booking System'
  end

end

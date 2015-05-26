class Public::CalendarsController < PublicController

  def my_calendar
    @events = current_user.events
  end
end
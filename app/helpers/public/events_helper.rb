module Public::EventsHelper
  
  def current_user_attending event_id
    attending = EventAttendee.where(event_id: event_id, user_id: current_user.id)
    attending.size == 0 ? false : true
  end

  def find_event_attendee user_id, event_id
    @attending ||= EventAttendee.where(event_id: event_id, user_id: user_id)
    if @attending.present?
      @attending.first.id
    end
  end

  def attendees_ids event
    attending_ids = event.users.pluck(:id)
  end

end
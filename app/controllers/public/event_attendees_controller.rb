class Public::EventAttendeesController < PublicController

  layout :false
  
  def create
    @attendee = EventAttendee.create(event_attendee_params)
    if @attendee.save
      @success = true
    end
  end

  def destroy
    @attendee = EventAttendee.find(params[:id])
    @event = @attendee.event
    if @attendee.destroy
      @success = true
    end
  end

  private
    def event_attendee_params
      params.require(:event_attendee).permit(:event_id, :user_id)
    end
end
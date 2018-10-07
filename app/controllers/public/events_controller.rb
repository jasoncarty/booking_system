class Public::EventsController < PublicController

  layout false, except: [:index, :show_event]

  def index
    @events = Event.preload(event_attendees: :user)
              .where('starts_at > ?', Time.now)
              .order(starts_at: :asc)
              .paginate(page: params[:page], per_page: 10)

    @attendances = current_user.event_ids
    render component: 'common/components/Events/components/EventList',
      props: {
        events: @events.as_json(:include => {
          :event_attendees => {:include => :user}
        }),
        attendances: current_user.event_ids,
        adminSection: false
      }
  end

  def show
    @event = Event.preload(event_attendees: :user).find(params[:id])
    @attendances = current_user.event_ids
  end

  def book
    @event  = Event.preload(reserves: :user, attendees: :user).find(params[:id])
    @result = @event.add_user(current_user)
    @attendances = current_user.event_ids
    render json: { eventAttendees: @result, attendances: @attendances }
  end

  def cancel
    @event  = Event.preload(reserves: :user, attendees: :user).find(params[:id])
    @result = @event.remove_user(current_user)
    @attendances = current_user.event_ids
    render json: { eventAttendees: @result, attendances: @attendances }
  end

end
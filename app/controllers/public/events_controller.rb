class Public::EventsController < PublicController

  layout false, except: [:index, :show_event]

  def index
    @events = Event.includes(event_attendees: :user)
              .all
              .where('starts_at > ?', Time.now)
              .order(starts_at: :asc)
              .paginate(page: params[:page], per_page: 10)
  end

  def show
    @event = Event.find(params[:id])
  end

  def show_event
    @event = Event.find(params[:id])
  end

end
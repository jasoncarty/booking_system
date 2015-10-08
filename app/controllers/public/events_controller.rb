class Public::EventsController < PublicController

  layout false, except: [:index, :show_event]

  def index
    @events = Event.preload(attendees: :user, reserves: :user)
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

  def book
    @event  = Event.preload(reserves: :user, attendees: :user).find(params[:id])
    @result = @event.add_user(current_user)
  end

  def cancel
    @event  = Event.preload(reserves: :user, attendees: :user).find(params[:id])
    @result = @event.remove_user(current_user)
  end

end
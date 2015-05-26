class Public::EventsController < PublicController

  layout false, except: [:index, :show_event]

  def index
    @events = Event.all.order(id: :desc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def show_event
    @event = Event.find(params[:id])
  end
  
end
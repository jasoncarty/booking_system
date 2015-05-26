class Admin::EventsController < AdminController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      flash[:notice] = 'Changes saved'
      render :edit
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = 'Changes saved'
      render :edit
    else
      render :edit
    end
  end

  def event_params
    params.require(:event).permit(:name, :url, :description, :starts_at, :ends_at, :calendar_id, :user_ids => [])
  end

  def show
    @event = Event.find(params[:id])
  end

end
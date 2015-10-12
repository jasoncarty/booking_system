class Admin::EventsController < AdminController

  layout false, only: [:destroy]

  def index
    @events = Event.preload(event_attendees: :user)
              .where('starts_at > ?', Time.now)
              .order(starts_at: :asc)
              .paginate(page: params[:page], per_page: 10)
  end

  def old_events
    @events = Event.preload(event_attendees: :user)
              .where('starts_at < ?', Time.now)
              .order(starts_at: :asc)
              .paginate(page: params[:page], per_page: 10)
  end

  def new
    @event = Event.new
    @users = User.all
  end

  def create
    @event = Event.create(event_params)
    @users = User.all
    if @event.save
      if params['attendees'].present?
        @event.save_attendees params['attendees']
      end
      flash[:notice] = 'Changes saved'
      redirect_to admin_events_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.preload(attendees: :user, reserves: :user).find(params[:id])
    @users = User.not_attending(attendees_ids(params[:id]))
  end

  def update
    @event = Event.find(params[:id])
    @users = User.all
    if @event.update(event_params)
      # if params['attendees'].present?
      #   @event.update_attendees params['attendees']
      # else
      #   @event.remove_attendees
      # end
      flash[:notice] = 'Changes saved'
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def event_params
    params.require(:event).permit(
      :name,
      :url,
      :description,
      :starts_at,
      :ends_at,
      :calendar_id,
      :maximum_event_attendees,
      :attendee_user_ids => [],
      :reserve_user_ids => []
    )
  end

  def destroy
    @event = Event.find params[:id]
    if @event.destroy
      @result = 'success'
    else
      @result = @event.errors.messages
    end
    @result
  end

  def attendees_ids(event_id)
    <<-SQL
    SELECT event_attendees.user_id FROM event_attendees WHERE event_attendees.event_id = #{event_id}
    SQL
  end

end
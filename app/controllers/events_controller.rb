class EventsController < OpenReadController
  before_action :set_event, only: %i[update destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: current_user.events.all
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = current_user.events.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:event_type, :location, :bicycle_id)
    end
end

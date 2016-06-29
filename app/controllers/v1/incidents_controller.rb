class V1::IncidentsController < V1::BaseController
  before_action :authenticate_user!, only: :create

  # TODO: there is no way to update a comment or delete it.

  # Retrieve a spot's incidents.
  def index
    @incidents = Incident.where(spot_id: params[:spot_id])
  end

  # Create a new incident.
  def create
    @incident = Incident.new(parse_incident_params)

    unless @incident.save
      @incident.errors.full_messages.each do |msg|
        add_request_error(title: msg)
      end
      render status: :unprocessable_entity
    end
  end

  private

  ##
  # Parse incident parameters and convert them to internal values.
  def parse_incident_params
    create_params = params
                    .require(:incident)
                    .permit(:spot_id, :category, :comment)

    unless (spot = Spot.where(id: create_params[:spot_id]).first)
      add_request_error(title: I18n.t('api.request.errors.spot_not_found'))
    end

    {
      user: current_user,
      spot: spot,
      category: create_params[:category],
      comment: create_params[:comment]
    }.keep_if { |_, v| v.present? }
  end
end

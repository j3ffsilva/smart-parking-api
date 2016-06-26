class V1::IncidentsController < V1::BaseController
  def create
    if request_has_errors?
      render status: :bad_request
      return
    end
    @incident = Incident.create(parse_incident_params)
  end

  def last
    last_params = parse_last_params

    if request_has_errors?
      render status: :bad_request
      return
    end

    @incident = Incident.where(spot_id: last_params[:spot]).last
  end

  private

  def parse_last_params
    if params[:spot].nil?
      add_request_error(title: I18n.t('api.request.errors.invalid_spot'))
    end

    {
      spot: params[:spot]
    }.keep_if { |_, v| v.present? }
  end

  def parse_incident_params
    if params[:incident].nil?
      add_request_error(title: I18n.t('api.request.errors.invalid_incident'))
    end

    create_params = params.require(:incident).permit(:user, :spot, :category,
                                                     :comment)

    {
      user: User.find(create_params[:user]),
      spot: Spot.find(create_params[:spot]),
      category: create_params[:category],
      comment: create_params[:comment]
    }.keep_if { |_, v| v.present? }
  end
end

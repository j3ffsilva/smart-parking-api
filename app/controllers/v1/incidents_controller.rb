class V1::IncidentsController < V1::BaseController
  def create
    if request_has_errors?
      render status: :bad_request
      return
    end

    # REVIEW: should check if the incident was actually created.
    @incident = Incident.create(parse_incident_params)
  end

  def last
    last_params = parse_last_params

    if request_has_errors?
      render status: :bad_request
      return
    end

    # REVISIT: what happens if this is nil?
    @incident = Incident.where(spot_id: last_params[:spot]).last
  end

  private

  # REVIEW: an incident always belongs to a spot, so I think spot validations
  # could be merged into one.
  def parse_last_params
    if params[:spot].nil?
      # REVIEW: looks like this key doesn't exist.
      add_request_error(title: I18n.t('api.request.errors.invalid_spot'))
    end

    # REVISIT: spot or spot_id?
    { spot: params[:spot] }.keep_if { |_, v| v.present? }
  end

  ##
  # Parses incident parameters and convert them to internal values.
  def parse_incident_params
    if params[:incident].nil?
      # REVISIT: looks like the key doesn't exist.
      add_request_error(title: I18n.t('api.request.errors.invalid_incident'))
    end

    # TODO: [User integration] the :user will not be necessary.
    # REVISIT: is is spot or spot_id?
    create_params = params
                    .require(:incident)
                    .permit(:user, :spot, :category, :comment)

    # REVIEW: generate errors if these records don't exist.
    {
      user: User.find(create_params[:user]),
      spot: Spot.find(create_params[:spot]),
      category: create_params[:category],
      comment: create_params[:comment]
    }.keep_if { |_, v| v.present? }
  end
end

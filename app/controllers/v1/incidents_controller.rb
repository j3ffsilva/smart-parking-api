class V1::IncidentsController < V1::BaseController
  def incident_params
    params.require(:incident).permit(:user, :spot, :category, :comment)
  end

  def create
    if request_has_errors?
      render status: :bad_request
      return
    end

    @incident = Incident.create(user: User.find(incident_params[:user]),
                                spot: Spot.find(incident_params[:spot]),
                                category: incident_params[:category],
                                description: incident_params[:comment])

    check_pretty_render
  end
  def show
    if request_has_errors?
      render status: :bad_request
      return
    end

    @incident = Incident.where(spot: params[:spot]).last
    check_pretty_render
  end
end

class V1::IncidentsController < V1::BaseController
  def incident_params
    params.require(:incident).permit(:user, :spot, :category, :comment)
  end

  def create
    @incident = Incident.create(user: User.find(incident_params[:user]),
                                spot: Spot.find(incident_params[:spot]),
                                category: incident_params[:category],
                                comment: incident_params[:comment])
  end

  def last
    @incident = Incident.where(spot_id: params[:spot]).last
  end
end

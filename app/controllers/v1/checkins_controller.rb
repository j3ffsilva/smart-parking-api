class V1::CheckinsController < V1::BaseController
  def create
    @checkin = Checkin.create(post_checkin_params)
    #@checkin.save!
  end

  def search
    condition = 'user_id = ? AND checked_out_at is null'
    @checkin = Checkin.where(condition, params[:user_id].to_i)
  end

  def update
    @checkin = Checkin.find(params[:id].to_i)
    @checkin.update_attributes(put_checkin_params)
  end

  private

  def put_checkin_params
    {
      checked_out_at: Time.new
    }
  end

  def post_checkin_params
    {
      user_id: params[:user_id],
      spot_id: params[:spot_id],
      checked_in_at: Time.new,
      checked_out_at: ''
    }
  end
end

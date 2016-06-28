class V1::CheckinsController < V1::BaseController
  def create
    # REVIEW: check for errors on create.
    @checkin = Checkin.create(post_checkin_params)
    # REVIEW: remove unused code.
    #@checkin.save!
  end

  def search
    # REVIEW: use active record.
    # REVIEW: this is not a "search", so the action name could be improved.
    condition = 'user_id = ? AND checked_out_at is null'
    @checkin = Checkin.where(condition, params[:user_id].to_i)
  end

  def update
    # REVIEW: check for errors.
    @checkin = Checkin.find(params[:id].to_i)
    @checkin.update_attributes(put_checkin_params)
  end

  private

  # REVIEW: shouldn't this meethod be called checkout_params?
  # REVIEW: it's not necessary to put the HTTP method on the method name.
  def put_checkin_params
    {
      checked_out_at: Time.new
    }
  end

  # REVIEW: it's not necessary to put the HTTP method on the method name.
  def post_checkin_params
    # REVIEW: validate these params.
    {
      user_id: params[:user_id],
      spot_id: params[:spot_id],
      checked_in_at: Time.new,
      # REVIEW: if it's nil, it's not necessary to declare this key.
      checked_out_at: ''
    }
  end
end

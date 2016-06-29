class V1::CheckinsController < V1::BaseController
  before_action :authenticate_user!

  def create
    @checkin = Checkin.new(create_checkin_params)

    unless @checkin.save
      @checkin.errors.full_messages.each do |msg|
        add_request_error(title: msg)
      end
      render status: :unprocessable_entity
    end
  end

  def pending
    @checkin = Checkin.where(user: current_user, checked_out_at: nil).first || Checkin.new
    render action: :create
  end

  def checkout
    @checkin = Checkin.where(user: current_user, checked_out_at: nil).first

    unless @checkin
      render action: :create, status: :bad_request
      return
    end

    render action: :create
  end

  private

  def create_checkin_params
    unless (spot = Spot.where(id: params[:spot_id]).first)
      add_request_error(title: I18n.t('api.request.errors.spot_not_found'))
    end

    {
      user_id:       current_user.id,
      spot_id:       (spot || Spot.new).id,
      checked_in_at: Time.zone.now,
    }
  end
end

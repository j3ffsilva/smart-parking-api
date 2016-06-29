class V1::SpotsController < V1::BaseController
  # Default search range, in meters.
  DEFAULT_RANGE = 2_000

  def search
    search_params = parse_search_params

    if request_has_errors?
      render status: :bad_request
      return
    end

    # Search for spots.
    @spots = Spot.search(search_params)

    # Set request metadata.
    @meta = search_params.merge(
      count: @spots.count,
      timestamp: Time.now.to_f.to_s
    )

    check_pretty_render
  end

  private

  # Parses search parameters and:
  # - Makes necessary validations
  # - Makes necessary type conversions
  # - Sets defaults for optional parameters
  def parse_search_params
    if params[:lat].nil? || !Geo::Coordinates::Latitude.new(params[:lat]).valid?
      add_request_error(title: I18n.t('api.request.errors.invalid_lat'))
    end

    if params[:lng].nil? || !Geo::Coordinates::Latitude.new(params[:lng]).valid?
      add_request_error(title: I18n.t('api.request.errors.invalid_lng'))
    end

    if (range = params[:range].to_i) == 0
      range = DEFAULT_RANGE
    end

    if (params[:google_place_id] &&
        Establishment.where(google_place_id: params[:google_place_id]).empty?)
      add_request_error(title: I18n.t('api.request.errors.establishment_not_found'))
    end

    if (params[:statuses])
      (statuses = params[:statuses].split(',')).each do |status|
        if status !~ /\A\d\z/
          add_request_error(
            title: I18n.t('api.request.errors.invalid_status', status: status)
          )
        end
      end

    end

    {
      lat: params[:lat],
      lng: params[:lng],
      range: range,
      google_place_id: params[:google_place_id],
      statuses: statuses
    }.keep_if { |_, v| v.present? }
  end
end

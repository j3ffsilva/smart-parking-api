module SmartCityPlatform
  class DiscoveryService
    BASE_URL = "http://#{Rails.application.config_for(:services)['discovery_service']}"

    ##
    # Send a request to get spots given a location and a radius.
    def self.radius_search(params)
      response = RestClient.get("#{BASE_URL}/discovery/resources", params: {
        capability: :spot_availability,
        lat:        params[:lat],
        lon:        params[:lng],
        radius:     params[:range]
      })

      components = JSON.load(response)['resources']
      { success: true, data: components }

    rescue => ex
      error_message = <<-ERR
        [error] Could not perform search with Discovery Service.
          Reason: #{ex.message}
      ERR
      Rails.logger.error(error_message.strip)
      { success: false }
    end
  end
end

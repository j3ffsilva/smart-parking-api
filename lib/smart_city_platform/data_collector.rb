module SmartCityPlatform
  class DataCollector
    BASE_URL = "http://#{Rails.application.config_for(:services)['data_collector']}"

    ##
    # Send a request to get the latest sensor values given their UUIDs.
    def self.latest_values(uuids)
      response = RestClient.post("#{BASE_URL}/resources/data/last",
        sensor_value: {
          uuids: uuids
        }
      )

      components = JSON.load(response)['resources']
      { success: true, data: components }

    rescue => ex
      error_message = <<-ERR
        [error] Could not perform search with Data Collector.
          Reason: #{ex.message}
      ERR
      error_message = error_message.strip
      Rails.logger.error(error_message)
      { success: false }
    end
  end
end

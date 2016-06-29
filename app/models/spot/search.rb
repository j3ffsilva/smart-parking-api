class Spot
  class Search
    # If true, all searches will be local and NOT use the Platform's services.
    # We'll change this flag to false after integration is finished.
    FORCE_LOCAL = true

    ##
    # Search for spots matching the desired criteria.
    # We first try to perform a remote search, using the services from the
    # Smart City Platform. If the remote search fails, then we fallback to
    # a local search.
    def search(args)
      @args = args

      if FORCE_LOCAL
        local_search
      else
        remote_search or local_search
      end
    end

    ##
    # Search for spots using the Platform's services.
    def remote_search
      discovery_results = SmartCityPlatform::DiscoveryService.radius_search(@args)
      return false unless discovery_results[:success]

      spots = merge_components({}, discovery_results)

      if @args[:statuses]
        uuids = discovery_results[:data].map { |c| c['uuid'] }
        collector_results = SmartCityPlatform::DataCollector.latest_values(uuids)
        return false unless collector_results[:success]

        spots = merge_components(spots, collector_results)

        filtered = spots.select do |_, value|
          value['capabilities']['spot_availability'].first['value']
                                                    .to_i
                                                    .in?(@args[:statuses])
        end
      else
        filtered = spots
      end

      find_by_latlng(filtered)
      include_establishment
      @spots
    end

    ##
    # Search for spots using our own database. This is a fallback in case
    # the Platform's services are unavailable.
    def local_search
      @spots = Spot.within_radius(*@args.fetch_values(:range, :lat, :lng))

      if @args[:statuses]
        @spots = @spots.where(status: @args[:statuses])
      end

      include_establishment
      @spots
    end

    private

    ##
    # Given a spots hash, indexed by their uuids, and remote results,
    # merge results into the original hash using the uuid as key.
    def merge_components(spots, results)
      results[:data].each do |component|
        if spots[component['uuid']]
          spots[component['uuid']].merge!(component)
        elsif spots.any?
          raise "Unmatched component: #{component['uuid']}"
        else
          spots[component['uuid']] = component
        end
      end
      spots
    end

    ##
    # Find spots by their (lat, lng) values.
    def find_by_latlng(remote_components)
      param_pairs = []
      latlngs     = []

      remote_components.values.each do |hsh|
        param_pairs << '(?, ?)'
        latlngs << hsh['lat']
        latlngs << hsh['lon']
      end

      @spots = Spot.where("(latitude, longitude) IN (#{param_pairs.join(',')})", *latlngs)
    end

    ##
    # Join spots with establishments, if necessary.
    #
    def include_establishment
      if @args[:google_place_id]
        @spots = @spots
                 .joins(:establishment)
                 .where(
                   'establishments.google_place_id' => @args[:google_place_id]
                 )
      end
    end
  end
end

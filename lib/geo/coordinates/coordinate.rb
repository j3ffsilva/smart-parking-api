module Geo
  module Coordinates
    # Represents a geospatial coordinate (either latitude or longitude).
    class Coordinate
      using Refinements::StringNumeric

      attr_accessor :value

      def initialize(value)
        self.value = value
      end

      def valid?
        return false unless value.numeric?
        (self.class::MIN..self.class::MAX).cover?(Float(value))
      end
    end
  end
end

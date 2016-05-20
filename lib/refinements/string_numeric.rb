module Refinements

  # Defines String#numeric? method.
  module StringNumeric
    refine String do

      # @return [Boolean] whether the string is a valid representation of a
      #   number.
      def numeric?
        return true if self =~ /\A\d+\Z/
        true if Float(self) rescue false
      end

    end
  end

end

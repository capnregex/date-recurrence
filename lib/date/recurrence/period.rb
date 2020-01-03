class Date
  class Recurrence
    class Period
      attr_reader :recurrence, :starts
      def initialize(recurrence, starts)
        @recurrence = recurrence
        @starts = starts
      end
    end
  end
end


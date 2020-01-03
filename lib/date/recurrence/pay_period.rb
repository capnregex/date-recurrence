require 'date/recurrence/pay_period/calculations'
class Date
  class Recurrence
    class PayPeriod
      # @NOTE: 01/07/2018 is the starting date for pay periods in 2018
      # (https://www.nfc.usda.gov/Publications/Forms/pay_period_calendar.php has pay period dates)
      class_attribute :origin, default: Date.new(2018, 1, 7)
      class_attribute :duration, default: 14 # days
      delegate :origin, :duration, :new, to: :class
      attr_reader :starts

      def initialize(date=nil)
        @starts = (date.to_date || Time.zone.today).beginning_of_pay_period
      end

      def ends
        @ends ||= starts.days_since(duration - 1)
      end

      def range
        @range ||= starts..ends
      end

      def next
        new(day(duration))
      end

      def prev
        new(starts.days_ago(duration))
      end

      def day(index)
        if index.negative? 
          ends.days_since(index + 1)
        else
          starts.days_since(index)
        end
      end

      def days
        range.to_a
      end

      def cover?(date)
        range.cover? date
      end
    end
  end
end


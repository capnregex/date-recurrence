require 'date/recurrence/pay_period/calculations'
class Date
  module Recurrence
    class PayPeriod
      # @NOTE: 01/07/2018 is the starting date for pay periods in 2018
      # (https://www.nfc.usda.gov/Publications/Forms/pay_period_calendar.php has pay period dates)
      class_attribute :origin, default: Date.new(2018, 1, 7)
      class_attribute :duration, default: 14 # days
      delegate :origin, :duration, :new, to: :class
      attr_reader :first

      def initialize(date=nil)
        @first = (date.to_date || Time.zone.today).beginning_of_pay_period
      end

      def last
        @last ||= first.days_until(duration - 1)
      end

      def range
        @range ||= first..last
      end

      def next
        new(day(duration))
      end

      def prev
        new(first.days_ago(duration))
      end

      def day(index)
        first.days_until(index)
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


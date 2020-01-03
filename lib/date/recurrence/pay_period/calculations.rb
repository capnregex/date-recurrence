require 'active_support'
require 'active_support/core_ext/class/attribute' # class_attribute
require 'active_support/core_ext/numeric/time' # 5.weeks.from_now
require 'active_support/core_ext/integer/time' # 5.weeks.from_now
require 'active_support/core_ext/date/calculations' # beginning_of_week
require 'active_support/core_ext/module/attribute_accessors' # cattr_ mattr_

class Date
  class Recurrence
    class PayPeriod
      module Calculations
        def pay_period_origin
          Date::Recurrence::PayPeriod.origin
        end

        def pay_period_duration
          Date::Recurrence::PayPeriod.duration
        end

        def days_to_pay_period_origin
          self.to_date - pay_period_origin
        end

        def days_to_pay_period_start
          (days_to_pay_period_origin % pay_period_duration).to_i
        end

        def days_to_pay_period_end
          pay_period_duration - days_to_pay_period_start - 1
        end

        def days_to_next_pay_period
          pay_period_duration - days_to_pay_period_start
        end

        def beginning_of_pay_period
          result = days_ago(days_to_pay_period_start)
          acts_like?(:time) ? result.midnight : result
        end

        def ending_of_pay_period
          result = days_since(days_to_pay_period_end)
          acts_like?(:time) ? result.midnight : result
        end

        def next_pay_period_start
          result = days_since(days_to_next_pay_period)
          acts_like?(:time) ? result.midnight : result
        end

        def beginning_of_pay_period?
          days_to_pay_period_start == 0
        end

        def pay_period
          PayPeriod.new(self)
        end
      end
    end
  end
end
Date.include Date::Recurrence::PayPeriod::Calculations
Time.include Date::Recurrence::PayPeriod::Calculations


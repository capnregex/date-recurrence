require 'active_support'
#require 'active_support/core_ext/'
require 'active_support/core_ext/class/attribute' # class_attribute
require 'active_support/core_ext/module/attribute_accessors' # cattr_ mattr_
require 'active_support/core_ext/numeric/time' # 5.weeks.from_now
require 'active_support/core_ext/integer/time' # 5.weeks.from_now
require 'active_support/core_ext/date/calculations' # beginning_of_week
require "date/recurrence/version"
require "date/recurrence/period"

class Date
  class Recurrence
    cattr_accessor :origin, default: Date.new(2017, 1, 1) # new years day on sunday
    cattr_accessor :frequencies, default: {
      daily: { days: 1 },
      weekly: { days: 7 },
      biweekly: { days: 14 },
      monthly: { months: 1 },
      quarterly: { months: 3 },
      yearly: { years: 1 }
    }
    cattr_accessor :frequency, default: :biweekly
    cattr_accessor :on
    attr_accessor :options, :starting, :ending, :repeats

    def initialize **options
      return if options.empty?
      every(options) if options.has_key? :every
      self.starting = options.delete(:starting) || options.delete(:starts)
      self.ending = options.delete(:ending) || options.delete(:until) || options.delete(:through) || options.delete(:ends)
      self.repeats = options.delete(:repeats)
      self.origin = options.delete(:origin) if options.has_key? :origin
      self.frequency = options.delete(:frequency) if options.has_key? :frequency
      self.on = options.delete(:on) if options.has_key? :on
      self.options = options
    end

    def every(**options)
      every = options.delete(:every)
      interval = options.delete(:interval) || 1
      case every
      when :day, 'day'
        self.frequency = { days: interval }
      when :week, 'week'
        self.frequency = { days: interval * 7 }
      when :month, 'month'
        self.frequency = { months: interval }
      when :year, 'year'
        self.frequency = { years: interval }
      end
    end

    def duration
      frequency[:days]
    end

    def days_to_origin(date)
      date - origin
    end

    def days_to_period_start(date)
      if (days = frequency[:days])
        days_to_origin(date) % days
      elsif (months = frequency[:month])
        # if months == 1
        #  date.
        # end
      end
    end

    def period_for(date)
      Date::Recurrence::Period.new(self,date)
    end
  end
end

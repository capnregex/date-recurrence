require 'active_support'
#require 'active_support/core_ext/'
require 'active_support/core_ext/class/attribute' # class_attribute
require 'active_support/core_ext/module/attribute_accessors' # cattr_ mattr_

require 'active_support/core_ext/numeric/time' # 5.weeks.from_now
require 'active_support/core_ext/integer/time' # 5.weeks.from_now

require 'active_support/core_ext/date/calculations' # beginning_of_week

require "date/recurrence/version"

class Date
  module Recurrence
    # Your code goes here...
  end
end

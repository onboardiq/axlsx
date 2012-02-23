# encoding: UTF-8
require "date"

module Axlsx
  # The DateTimeConverter class converts both data and time types to their apprpriate excel serializations  
  class DateTimeConverter
    
    # The date_to_serial method converts Date objects to the equivelant excel serialized forms
    # @param [Date] date the date to be serialized
    # @return [Numeric]
    def date_to_serial(date)
      epoc = Axlsx::Workbook::date1904 ? Date.new(1904) : Date.new(1899, 12, 30)
      (date-epoc).to_f
    end

    # The time_to_serial methond converts a Time object its excel serialized form.
    # @param [Time] time the time to be serialized
    # @return [Numeric]
    def time_to_serial(time)
      # Using hardcoded offsets here as some operating systems will not except
      # a 'negative' offset from the ruby epoc.
      epoc1900 = -2209161600 # Time.utc(1899, 12, 30).to_i
      epoc1904 = -2082844800 # Time.utc(1904, 1, 1).to_i
      seconds_per_day = 86400 # 60*60*24
      epoc = Axlsx::Workbook::date1904 ? epoc1904 : epoc1900
      (time.to_f - epoc)/seconds_per_day
    end
  end
end

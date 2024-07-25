require 'csv'
require 'time'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def get_date(reg_date)
  Time.strptime(reg_date, "%m/%d/%Y %k:%M") {|y| y + 2000 }
end

def find_frequency(array)
  freq = array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  sorted_freq = freq.sort_by { |_, count| count }.reverse
  top_two = sorted_freq.take(2).map { |num, _| num }
  top_two
end

hours_array = []
weekday_array = []
contents.each do |row|
  reg_date = row[:regdate]
  date = get_date(reg_date)
  hour = date.hour
  hours_array.push(hour)

  weekday = date.wday
  weekday_array.push(weekday)
end
p find_frequency(hours_array)
p find_frequency(weekday_array)

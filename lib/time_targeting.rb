require "csv"
require "time"

hours = []

def get_hour(date)
  Time.strptime(date, "%Y/%d/%m %R").hour
end

contents = CSV.open("event_attendees.csv",
                    headers: true,
                    header_converters: :symbol)

contents.each do |row|
  date = row[1]
  hours.push(get_hour(date))
end

freq = hours.each_with_object(Hash.new(0)) do |v, h|
  h[v] += 1
end
puts hours.max_by(2) { |v| freq[v] }

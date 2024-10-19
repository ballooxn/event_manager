require "csv"
require "time"

reg_hours = []

def get_hour(date)
  Time.strptime(date, "%Y/%d/%m %R").hour
end

contents = CSV.open("event_attendees.csv",
                    headers: true,
                    header_converters: :symbol)

contents.each do |row|
  date = row[1]
  reg_hours.push(get_hour(date))
end

top_hours = reg_hours.uniq.max_by(2) { |h| reg_hours.count(h) }
puts top_hours

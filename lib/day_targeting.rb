require "csv"
require "time"

DAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze

registration_days = []

def get_date(date)
  Time.strptime(date, "%Y/%d/%m %R")
end

contents = CSV.open("event_attendees.csv",
                    headers: true,
                    header_converters: :symbol)

contents.each do |row|
  date = get_date(row[1])
  day_number = date.wday
  day = DAYS[day_number]
  registration_days.push(day)
end

freq = registration_days.each_with_object(Hash.new(0)) do |v, h|
  h[v] += 1
end
puts registration_days.max_by(2) { |v| freq[v] }

require "csv"
require "time"

DAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze

reg_days = []

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
  reg_days.push(day)
end

top_days = reg_days.uniq.max_by(2) { |d| reg_days.count(d) }
puts top_days

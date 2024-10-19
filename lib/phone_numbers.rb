require "csv"

def format_number(number)
  number.gsub!(/[().\-\s]/, "")
  number
end

def clean_number(number)
  number = format_number(number)
  return "Bad number" if number.nil?

  length = number.length

  return "Bad number" if length < 10 || length > 11

  return number if length == 10

  return number.slice[0] if length == 11 && number[0] == 1

  "Bad number"
end

contents = CSV.open("event_attendees.csv",
                    headers: true,
                    header_converters: :symbol)

contents.each do |row|
  phone_number = row[5]
  phone_number = clean_number(phone_number)

  puts phone_number
end

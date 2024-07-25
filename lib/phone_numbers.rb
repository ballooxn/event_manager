require "csv"

contents = CSV.open(
  "event_attendees.csv",
  headers: true,
  header_converters: :symbol
)
puts contents

def format_phone_number(number)
  arr = []
  number.chars.each do |i|
    next unless i =~ /\A[0-9]\Z/

    arr.push(i)
  end
  arr
end

def clean_phone_numbers(number)
  number_array = format_phone_number(number)
  if number_array.length == 10
    number_array.join
  elsif number_array.length < 10
    0
  elsif number_array.length == 11 && number_array[0] == "1"
    number_array.join[1..]
  else
    0
  end
end

contents.each do |row|
  phone_number = clean_phone_numbers(row[:homephone])
  puts phone_number
end

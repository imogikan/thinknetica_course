require 'pry'
require 'date'
require 'pp'

months_count = (1..12).to_a
month_with_days = {}

months_count.each do |month|
  current_year = Date.today.year
  days_in_month = Date.new(current_year, month, -1).day
  full_month = Date.parse("#{current_year}-#{month}-#{days_in_month}").strftime("%B")
  month_with_days[full_month] = days_in_month
end

puts "-- We've created all months with all days"
pp month_with_days

month_with_days.each do |month, days|
  if days == 30
    puts "---"*10
    puts "-- Month '#{month}' have a 30 days"
  end
end

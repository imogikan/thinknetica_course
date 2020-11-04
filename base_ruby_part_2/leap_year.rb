def get_value(value)
  puts "Insert #{value}:"
  gets.chomp.to_i
end

day = get_value('day')
month = get_value('month')
year = get_value('year')

day_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
day_of_month[1] += 1 if (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)

puts "Order number of date: #{day_of_month.take(month - 1).sum + day}"
require 'colorize'

TEXT = {
    height_error: 'Invalid number. Insert correct number'.red,
}

def get_value(value)
  loop do
    puts "Insert #{value}:"
    result = gets.chomp
    return result.to_i if check_int?(result)
  end
end

def check_int?(int)
  unless int[/^\d+$/]
    puts TEXT[:height_error]
    return false
  end
  true
end

def leap_year?(year)
  (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
end

def yday(day, month, year)
  day_of_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  day_of_month[1] += 1 if leap_year?(year)
  day_of_month.take(month - 1).sum + day
end

day = get_value('day')
month = get_value('month')
year = get_value('year')
puts "Order number of date: #{yday(day, month, year)}"
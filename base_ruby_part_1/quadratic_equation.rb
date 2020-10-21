require 'pry'
require 'colorize'

def get_all_coefficients
  puts "-- Введите коэффициенты A, B и C".yellow
  coefficients = {}
  ['A', 'B', 'C'].each do |coefficient|
    coefficients[coefficient] = get_value(coefficient).to_i
  end
  puts "-- Ваши коэфециенты A=#{coefficients['A']}, B=#{coefficients['B']} и C=#{coefficients['C']}".yellow

  coefficients
end

def get_value(coefficient)
  loop do
    puts "-- Введите коэффициет #{coefficient} ".light_blue
    answer = gets.chomp
    return answer if correct_value?(answer, coefficient)
  end
end

def correct_value?(answer, coefficient)
  puts "-- Проверка коэффициента #{coefficient} ".yellow
  unless answer[/(-*\d+)/, 1] == answer
    puts "-- Пожалуйста, введите число".red
    return false
  end
  puts "-- Коэффициент #{coefficient} введен верно".green

  true
end

def calculate_result(coefficients)
  a, b, c = coefficients['A'], coefficients['B'], coefficients['C']
  # binding.pry
  discriminant = get_discriminant(a, b, c)

  if discriminant.positive?
    discriminant_more_then_one(a, b, c, discriminant)
  elsif discriminant.zero?
    discriminant_equal_one(a, b, discriminant)
  else
    puts "-- Дискриминант D=#{discriminant}, корней нет"
  end
end

def get_discriminant(a, b, c)
  puts "-- Считаем дискриминант D"
  discriminant = b**2 - 4*a*c
  discriminant
end

def discriminant_more_then_one(a, b, c, discriminant)
  c = Math.sqrt(discriminant)
  х1 = (b*-1 + c)/(2*a)
  x2 = (b*-1 - c)/(2*a)
  puts "-- Мы получили корни со значением x1=#{х1}, x2=#{x2} и дискрминант D=#{discriminant}"
end

def discriminant_equal_one(a, b, discriminant)
  x1 = x2 = -1*b/(2*a)
  puts "-- Мы получили корни со значением x1=#{x1}, x2=#{x2} и дискрминант D=#{discriminant}"
end

calculate_result(get_all_coefficients)

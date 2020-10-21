require 'pry'
require 'colorize'

def correct_value?(number)
  if number <= 0
    puts "-- Пожалуйста, введите число > 0".red
    return false
  end

  true
end

def get_value(value)
  puts "-- Введите #{value} треугольника".blue

  answer = gets.chomp.to_i

  answer
end

def cheking_values(values = {})
  values.map do |key, value|
    puts "-- Проверка значения #{key} треугольника".yellow

    until correct_value?(values[key])
      values[key] = get_value('высоту') if key == :height
      values[key] = get_value('основание') if key == :base
    end

    puts "-- Значение #{key} треугольника введено верно".green
  end

  values
end

def get_square(values)
  base = values[:base]
  height = values[:height]
  square = (0.5 * height * base).round(2)

  puts "-- Площадь треугольника с высотой: #{height} и основанием: #{base}, равна #{square}".green
  square
end

height = get_value('высоту')


base = get_value('основание')

values = cheking_values(
  height: height,
  base: base
)

get_square(values)


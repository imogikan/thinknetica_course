require 'pry'
require 'colorize'

def get_all_sides
  sides = []
  1.upto(3).each do |number|
    sides << get_value(number)
  end
  puts "-- У нас получился треугольник со сторонами #{sides[0]}, #{sides[1]} и #{sides[0]}".yellow

  sides.sort
end

def get_value(value)
  puts "-- Введите #{value} cторону треугольника".light_blue

  answer = gets.chomp.to_i

  puts "-- Проверка #{value} стороны треугольника".yellow

  until correct_value?(answer)
    answer = get_value(value)
  end

  puts "-- Значение #{value} стороны треугольника введено верно".green

  answer
end

def correct_value?(number)
  if number <= 0
    puts "-- Пожалуйста, введите число > 0".red
    return false
  end

  true
end

def which_rectangle(sides)
  puts "-- Определим вид треугольника".yellow
  if is_right?(sides)
    output(sides,"прямоугольным")
  elsif equilateral?(sides)
    output(sides,"равнобедренным и равносторонним")
  elsif isosceles?(sides)
    output(sides,"равнобедренным")
  else
    output(sides,"неизвестным")
  end

end

def output(sides, text)
  puts "-- Треугольник со сторонами #{sides[0]}, #{sides[1]} и #{sides[2]} является #{text}".green
end

def is_right?(sides)
  hypotenuse = sides.last
  return true if hypotenuse**2 == (sides[0]**2 + sides[1]**2)

  false
end

def isosceles?(sides)
  return true if sides.uniq.size == 2

  false
end

def equilateral?(sides)
  return true if sides.uniq.size == 1

  false
end

sides = get_all_sides
which_rectangle(sides)




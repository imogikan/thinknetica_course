def get_value(value)
  puts "Введите Ваш " + value

  answer = gets.chomp
  answer = answer.capitalize if value == 'имя'

  answer
end

def correct_height?(height)
  if height <= 0
    puts "Вы ввели отрицательный рост или фразу. Пожалуйста, введите число >= 0"
    return false
  end

  true
end

def ideal_weight?(name, height)
  ideal_weight = (height - 110) * 1.15
  if ideal_weight < 0
    puts "#{name}, Ваш вес уже оптимальный!"
  else
    puts "#{name}, Ваш идеальный вес #{ideal_weight.round(1)}!"
  end
end

puts "-- LET'S GET IDEAL WEIGHT"

name = get_value('имя')
height = get_value('рост').to_i

until correct_height?(height)
  height = get_value('рост')
end

ideal_weight?(name, height)






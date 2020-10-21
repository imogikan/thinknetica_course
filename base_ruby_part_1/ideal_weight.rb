require 'pry'
def get_value(value)
  loop do
    puts "Введите значение " + value
    answer = gets.chomp

    if value == 'имя'
      return answer.capitalize!
    else
      return answer if correct_height?(answer)
    end
  end
end

def correct_height?(height)
  unless height[/(\d+)/, 1] == height
    puts "Вы ввели отрицательный рост или фразу. Пожалуйста, введите число >= 0"
    return false
  end

  true
end

def ideal_weight?(name, height)
  ideal_weight = (height.to_i - 110) * 1.15
  if ideal_weight < 0
    puts "#{name}, Ваш вес уже оптимальный!"
  else
    puts "#{name}, Ваш идеальный вес #{ideal_weight.round(1)}!"
  end
end

puts "-- LET'S GET IDEAL WEIGHT"

name = get_value('имя')
height = get_value('рост')

ideal_weight?(name, height)






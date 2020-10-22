require 'pry'
def calculate_number(number)
  fibonacci_seq(0, 1, number)
end

def fibonacci_seq(first, second, number)
  number == 0 ? first : fibonacci_seq(second, first + second, number - 1)
end

p (0..100).map { |number| calculate_number(number) }
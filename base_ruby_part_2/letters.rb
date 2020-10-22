require 'pry'
require 'pp'

vowel_letters_with_order_number = {}
("a".."z").each_with_index do |letter, index|
  vowel_letters_with_order_number[letter] = index + 1 if letter[/[aeoui]/]
end

pp vowel_letters_with_order_number
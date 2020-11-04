require 'pry'
require 'pp'

vowel_letters_with_order_number = {}
("a".."z").each.with_index(1) do |letter, index|
  vowel_letters_with_order_number[letter] = index if letter[/[aeoui]/]
end

pp vowel_letters_with_order_number
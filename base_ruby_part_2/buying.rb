require 'colorize'

TEXT = {
    height_error: 'Invalid number. Insert number without symbols!'.red,
}

def create_products
  products = []
  loop do
    hash = {}
    name = get_value('product name')
    break unless name
    hash[name] = {}
    hash[name]['price'] = get_value('price')
    hash[name]['count'] = get_value('count')
    products << hash
  end
  products
end

def get_value(value)
  loop do
    puts "Insert #{value}:"
    result = gets.chomp
    return false if result[/стоп/]
    case value
    when /price|count/
      return result.to_i if check_int?(result)
    else
      return result
    end
  end
end

def check_int?(int)
  unless int[/^\d+$/]
    puts TEXT[:height_error]
    return false
  end
  true
end

def total_amount(hash)
  hash.each do |k, v|
    puts "#{k}: #{v['price'] * v['count']}"
  end
end

products = create_products
puts "Hash with products:\n#{products}"
puts "Final price per product:"
products.each do |i|
  total_amount(i)
end
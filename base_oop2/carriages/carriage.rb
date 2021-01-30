require_relative '../mixins/manufacturer'
require 'pry'

class Carriage
  attr_reader :type, :capacity
  include Manufactuter

  def initialize(type, capacity)
    @type = type
    @capacity = capacity
  end

end

carr = Carriage.new('new', 100)


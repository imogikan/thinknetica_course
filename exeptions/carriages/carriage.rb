require_relative '../mixins/manufacturer'
require 'pry'

class Carriage
  attr_reader :type, :capacity
  include Manufactuter

  def initialize(type, capacity)
    @type = type
    @capacity = capacity
    raise unless valid?
  end

  private

  def valid?
    return false if type.nil? || type.empty? || capacity.nil?
    return false unless capacity.positive?

    true
  end

end

carr = Carriage.new('new', 100)


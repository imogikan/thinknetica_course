require_relative '../mixins/manufacturer'
require 'pry'

class Carriage
  attr_reader :type, :capacity
  include Manufactuter

  def initialize(type, capacity)
    @type = type
    @capacity = capacity
    valid?
  end

  private

  def valid?
    raise "-- Params can't be blank or nil" if type.nil? || type.empty? || capacity.nil?
    raise "-- Capacity should be great then zero" unless capacity.positive?

    true
  end

end

carr = Carriage.new('new', 100)


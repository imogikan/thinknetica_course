# frozen_string_literal: true

require_relative '../mixins/manufacturer'
require_relative '../validation'
require 'pry'

class Carriage
  attr_reader :type, :capacity, :available_capacity

  include Manufactuter
  include Validation

  validate :capacity, :presence
  validate :type, :check_type, Symbol

  def initialize(type, capacity)
    @type = type
    @capacity = @available_capacity = capacity
    # raise unless valid?
  end

  def take_capacity(capacity = 1)
    @available_capacity -= capacity
  end

  def show_available_capacity
    @available_capacity
  end

  def show_taken_capacity
    @capacity - @available_capacity
  end

  private

  def valid?
    return false if type.nil? || type.empty? || capacity.nil?
    return false unless capacity.positive?

    true
  end
end

c1 = Carriage.new(:cargo, 100)
c1.validate!

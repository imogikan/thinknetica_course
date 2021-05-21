# frozen_string_literal: true

require_relative '../mixins/manufacturer'
require_relative '../mixins/instance_counter'
require 'pry'
require 'active_support/all'

class Train
  attr_accessor :speed, :route, :current_station
  attr_reader :number, :type, :carriages

  include Manufactuter
  include InstanceCounter

  SPEED_STEP = 10
  NAME_FORMAT = /[\d\w]{3}-*(?<=\-)([\d\w]{2})*/.freeze

  @@all_trains = []

  def self.find(number)
    @@all_trains.find { |train| train.number == number }
  end

  def initialize(number, type)
    @type = type
    @number = number
    @carriages = []

    self.speed = 0
    self.route = nil
    self.current_station = nil

    @@all_trains << self

    raise unless valid?

    validate_train_number!

    register_instance
  end

  def speed_up
    self.speed += SPEED_STEP
  end

  def speed_down
    self.speed = 0
  end

  def all_carriages
    return unless block_given?

    carriages.each do |carriage|
      yield carriage
    end
  end

  def change_length(type = :increase)
    return if speed.positive?

    case type
    when :increase
      @length += 1
    when :decrease
      return 'Length is already zero' if length.zero?

      @length -= 1
    end
  end

  def set_route(route)
    self.route = route
    move_train
  end

  def move_train(direction: :forward)
    return 'Route doesnt exist' unless route

    return "Next station doest't exist" unless next_station_exist?

    change_current_station(direction)
  end

  def take_carriage(carriage)
    if suitable_types?(carriage)
      @carriages << carriage
    else
      puts 'Types of train and carriage is different'
    end
  end

  def unhook_carriage
    carriage? ? carriages.pop : "Train doesn't have a carriages"
  end

  private

  def carriage?
    carriages.any?
  end

  def suitable_types?(carriage)
    type == carriage.type
  end

  def change_current_station(direction)
    if current_station
      current_station.send_train(self)
      current_station_number = route.get_station_number(current_station)

      case direction
      when :forward
        new_station_number = current_station_number.next
      when :back
        new_station_number = current_station_number.previous
      end

      self.current_station = route.stations[new_station_number]
    else
      self.current_station = route.stations.first
    end

    current_station.recieve_train(self)
  end

  def next_station_exist?
    return true unless current_station

    [route.stations.first, route.stations.last].include?(current_station)
  end

  private

  def valid?
    return false if type.nil? || type.empty? || number.nil?

    true
  end

  def validate_train_number!
    if number =~ /\-/
      unless number =~ /^[\d\w]{3}-[\d\w]{2}$/
        raise TrainError, "-- Invalid train name #{number}"
      end
    else
      unless number =~ /^[\d\w]{3}$/
        raise TrainError, "-- Invalid train name #{number}"
      end
    end

    puts "-- Train with number #{number} was successful created"
  end
end

class TrainError < StandardError; end

# tr1 = Train.new(123, :cargo)
# tr2 = Train.new(123, :cargo)
# tr3 = Train.new(123, :cargo)
#
# Train.find(122)

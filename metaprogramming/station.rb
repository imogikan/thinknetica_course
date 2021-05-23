# frozen_string_literal: true

require 'pry'
require_relative 'mixins/instance_counter'
require_relative 'validation'

class Station
  attr_reader :name, :trains

  include InstanceCounter
  include Validation

  @@all_stations = []

  validate :name, :presence
  validate :name, :check_type, String

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    # raise unless valid?

    @@all_stations << self

    register_instance
  end

  def recieve_train(train)
    if one_train?(train)
      trains << train
      return
    end

    puts "We can't recieve more than one train per time"
  end

  def send_train(train)
    if train_on_the_station?(train)
      trains.delete(train)
      puts "Train ##{train.number} was sucessfuly sent"
      return
    end

    puts "Station doesn't have train #{train.number}"
  end

  def all_trains_on_the_station(type = nil)
    case type
    when :cargo, :pass
      trains = @trains.select { |train| train.type == type }
    else
      trains = @trains
    end

    if block_given?
      trains.each do |train|
        yield train
      end
    end

    trains
  end

  private

  def train_on_the_station?(train)
    trains.include?(train)
  end

  def one_train?(train)
    train.is_a?(Array) && train.size > 1 ? false : true
  end

  def valid?
    return false if name.nil? || name.empty?

    true
  end
end


st1 = Station.new("Samara")
st1.validate!
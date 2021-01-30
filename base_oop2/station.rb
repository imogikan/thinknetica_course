require 'pry'
require 'mixins/instance_counter'

class Station
  attr_reader :name, :trains
  include InstanceCounter

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
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
      trains.select { |train| train.type == type }
    else
      trains
    end
  end

  private

  def train_on_the_station?(train)
    trains.include?(train)
  end

  def one_train?(train)
    train.is_a?(Array) && train.size > 1 ? false : true
  end
end

st1 = Station.new("one")
st2 = Station.new("two")
st2 = Station.new("three")
puts Station.all

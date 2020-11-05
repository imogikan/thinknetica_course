require 'pry'

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
    return if train.is_a?(Array) && train.size > 1

    true
  end

end

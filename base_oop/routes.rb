class Route
  attr_reader :stations

  def initialize(start_point, end_point)
    @stations = [start_point, end_point]
  end

  def insert_way_station(station)
    stations.insert(-2, station)
  end

  def delete_way_station(station)
    if station_exist?(station) && way_station?(station)
      stations.delete(station)
      puts "The station #{station} was sucessful delited from the route"
    end
  end

  def all_stations
    puts "The route have stations:\n"
    stations.each_with_index do |station, index|
      print "[#{index + 1}] #{station} || "
    end

    nil
  end

  def get_station_number(station)
    stations.index(station)
  end

  private

  def station_exist?(station)
    stations.include?(station)
  end

  def way_station?(station)
    @stations.first != station && @stations.last != station
  end
end

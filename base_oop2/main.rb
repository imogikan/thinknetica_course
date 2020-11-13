require_relative 'carriages/carriages_wrapper'
require_relative 'trains/trains_wrapper'
require_relative 'routes'
require_relative 'stations'
require 'pry'

class Trip
  attr_reader :stations, :trains, :routes, :carriages

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @carriages = []
  end

  def start_trip
    loop do
      data = get_user_data(addition_info: main_menu) { "Choice action:"}
      case data
      when 1
        create_station
      when 2
        create_train
      when 3
        manage_route
      when 4
        set_route_to_train
      when 5
        add_carriage_to_train
      when 6
        unhook_carriage_from_train
      when 7
        move_train
      when 8
        get_list_trains_or_stations
      when 9
        create_carriage
      when 0
        stop_application
      end
    end
  end

  private

  def main_menu
    puts '________________________________________________________________'
    puts '| 1 - Create station                                           |'
    puts '| 2 - Create train                                             |'
    puts '| 3 - Create route and manage stations                         |'
    puts '| 4 - Set route to the train                                   |'
    puts '| 5 - Add carriage to train                                    |'
    puts '| 6 - Unhook carriage from train                               |'
    puts '| 7 - Move train forward or back                               |'
    puts '| 8 - Get list of trains on stations or list of stations       |'
    puts '| 9 - Create carriage                                          |'
    puts '| 0 - Exit                                                     |'
    puts '________________________________________________________________'
  end

  def get_user_data(addition_info: nil, type: nil)
    puts yield if block_given?
    addition_info

    type == :name ? gets.chomp.capitalize : gets.chomp.to_i
  end

  def create_station
    name = get_user_data(type: :name) { "Insert station name:" }
    stations << Station.new(name)

    puts "Station '#{name}' was created"
  end

  def create_train
    number = get_user_data { "Insert number of train:" }
    type = get_user_data(addition_info: type_of_train_or_carriage) { "Insert type of train:" }
    case type
    when 1
      train = TrainWrapper.create_train(number, :pass)
    when 2
      train = TrainWrapper.create_train(number, :cargo)
    end

    trains << train

    puts "Train ##{number} was created"
  end

  def get_trains_on_the_station
    if stations.any?
      station_index = get_user_data(addition_info: avaiblable_stations(stations)) { puts "Choice station:"}
      selected_station = stations[station_index]

      option = get_user_data(addition_info: type_of_train_on_the_station) { "Choice type of train:" }

      case option
      when 1
        type = :pass
      when 2
        type = :cargo
      when 3
        type = nil
      end

      selected_station.all_trains_on_the_station(type)
    else
      puts "First, need to create station"
    end
  end

  def get_list_trains_or_stations
    option = get_user_data(addition_info: available_options) { "Choice needed option:" }
    case option
    when 1
      get_trains_on_the_station
    when 2
      get_all_stations
    end
  end

  def move_train
    train = select_train
    return unless train

    direction = get_user_data(addition_info: directions) { "Insert direction of moving:" }
    train.move_train(direction: direction)
  end

  def create_carriage
    type = get_user_data(addition_info: type_of_train_or_carriage) { "Insert type of carriage:" }
    capacity = get_user_data { "Insert capacity of carriage:" }

    case type
    when 1
      carriage = CarriageWrapper.create_carriage(:pass, capacity)
    when 2
      carriage = CarriageWrapper.create_carriage(:cargo, capacity)
    end

    carriages << carriage

    puts "Carriage with type '#{type}' and capaciy = #{capacity} was created"
  end

  def unhook_carriage_from_train
    train = select_train
    return unless train

    train.unhook_carriage
  end

  def add_carriage_to_train
    train = select_train
    return unless train
    binding.pry
    if available_carriages(train.type)
      carriage_index = get_user_data(addition_info: available_carriages(train.type)) { "Choice carriage:" }
      carriage = carriages[carriage_index]
    else
      puts "No available carriages for this train type #{train.type}"
      return
    end

    train.take_carriage(carriage)
  end

  def set_route_to_train
    train = select_train
    return unless train

    if routes.any?
      route_index = get_user_data(addition_info: available_trains) { "Choice route:" }
      route = routes[route_index]
    else
      puts "First, need to create route"
      return
    end

    train.set_route(route)

    puts "#{route_name(route)} was added to train ##{train.number}"
  end

  def manage_route
    choice = get_user_data(addition_info: manage_route_menu)
    case choice
    when 1
      create_route
    when 2
      add_station_to_route
    when 3
      delete_station_from_route
    when 0

    end
  end

  def delete_station_from_route
    route = select_route
    return unless route
    station = select_station("way", route, _for: :delete)
    return unless station

    route.delete_way_station(station)

    puts "Station '#{station.name}' was deleted from route #{route_name(route)}"
  end

  def add_station_to_route
    @available_stations = stations.dup

    route = select_route
    return unless route

    station = select_station("way", route, _for: :add)

    return unless station

    route.insert_way_station(station)

    puts "Station '#{station.name}' was added to route #{route_name(route)}"

  end

  def route_name(route)
    "'#{route.stations.first.name} - '#{route.stations.last.name}'"
  end

  def create_route
    @available_stations = stations.dup
    start = select_station("start", _for: :create)
    return unless start

    final = select_station("final", _for: :create)
    return unless final

    routes << Route.new(start, final)

    puts "Route #{route_name(routes.last)} was created"
  end

  def select_train
    if trains.any?
      train_index = get_user_data(addition_info: available_trains) { "Choice train:" }
      train = trains[train_index]
    else
      puts "First, need to create train"
      return
    end

    train
  end

  def select_route
    if routes.any?
      route_index = get_user_data(addition_info: avaiblable_routes) { puts "Choice route"}
      route = routes[route_index]
      return route
    end

    puts "There isn't available routes. Need to create route"

    false
  end

  def select_station(stage, route = nil, _for:)
    case _for
    when :create
      if @available_stations.any?
        station_index = get_user_data(addition_info: avaiblable_stations(@available_stations)) { puts "Choice #{stage} station:"}
        selected_station = @available_stations[station_index]
        @available_stations.delete(selected_station)

        return selected_station
      else
        puts "There isn't available stations to create route"
      end
    when :add
      available_stations_for_add = stations - route.stations
      if available_stations_for_add.any?
        station_index = get_user_data(addition_info: avaiblable_stations(available_stations_for_add)) { puts "Choice #{stage} station:"}
        selected_station = available_stations_for_add[station_index]

        return selected_station
      else
        puts "There isn't available stations to add. Need to create more stations"
      end
    when :delete
      available_stations_for_delete = route.stations[1..-2]
      if available_stations_for_delete.any?
        station_index = get_user_data(addition_info: avaiblable_stations(available_stations_for_delete)) { puts "Choice #{stage} station:"}
        selected_station = available_stations_for_delete[station_index]

        return selected_station
      else
        "There isn't available stations to delete."
      end
    end

    false
  end

  def available_trains
    trains.map(&:number).each_with_index { |number, index| p "#{index} - #{number}" }
  end

  def available_carriages(type)
    selected_cariages = carriages.select { |carriage| carriage.type == type }
    return unless selected_cariages

    selected_cariages.each.with_index { |carriage, index| p "#{index} - #{carriage.type} with capacity = #{carriage.capacity}" }
  end

  def avaiblable_routes
    routes.map { |route| route_name(route) }.each_with_index { |name, index| p "#{index} - #{name}" }
  end

  def avaiblable_stations(stations)
    stations.map(&:name).each_with_index { |name, index| p "#{index} - #{name}" }
  end

  def available_options
    puts '________________________________________________________________'
    puts '| 1 - Get trains on the station                                |'
    puts '| 2 - Get list of all stations                                 |'
    puts '________________________________________________________________'
  end

  def directions
    puts '________________________________________________________________'
    puts '| 1 - forward                                                  |'
    puts '| 2 - Back                                                     |'
    puts '________________________________________________________________'
  end

  def type_of_train_or_carriage
    puts '________________________________________________________________'
    puts '| 1 - Passenger                                                |'
    puts '| 2 - Cargo                                                    |'
    puts '________________________________________________________________'
  end

  def type_of_train_on_the_station
    puts '________________________________________________________________'
    puts '| 1 - Passenger                                                |'
    puts '| 2 - Cargo                                                    |'
    puts '| 3 - All                                                      |'
    puts '________________________________________________________________'
  end

  def manage_route_menu
    puts '________________________________________________________________'
    puts '| 1 - Create route                                             |'
    puts '| 2 - Add station to route                                     |'
    puts '| 3 - Delete station from route                                |'
    puts '| 0 - exit                                                     |'
    puts '________________________________________________________________'
  end

end

trip = Trip.new
trip.start_trip


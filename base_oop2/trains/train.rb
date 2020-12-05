class Train
  attr_accessor :speed, :route, :current_station
  attr_reader :number, :type, :carriages

  SPEED_STEP = 10

  def initialize(number, type)
    self.speed = 0
    @type = type
    @number = number
    @carriages = []
    self.route = nil
    self.current_station = nil
  end

  def speed_up
    self.speed += SPEED_STEP
  end

  def speed_down
    self.speed = 0
  end

  def change_length(type = :increase)
    if speed.positive?
      "We can't change train length. Train is moving. Need to stop its"
    else
      case type
      when :increase
        @length += 1
      when :decrease
        return "Length is already zero" if length.zero?
        @length -= 1
      end
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
    suitable_types?(carriage) ? @carriages << carriage : "Types of train and carriage is different"
  end

  def unhook_carriage
    have_carriage? ? carriages.pop : "Train doesn't have a carriages"
  end

  private

  def have_carriage?
    carriages.any?
  end

  def suitable_types?(carriage)
    self.type == carriage.type
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
end

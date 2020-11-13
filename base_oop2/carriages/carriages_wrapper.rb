require_relative 'pass_carriages'
require_relative 'cargo_carriages'

class CarriageWrapper
  def self.create_carriage(type, capacity)
    case type
    when :cargo
      CargoCarriage.new(type, capacity)
    when :pass
      PassCarriage.new(type, capacity)
    end
  end
end

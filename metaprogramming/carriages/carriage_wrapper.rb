# frozen_string_literal: true

require_relative 'pass_carriage'
require_relative 'cargo_carriage'

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

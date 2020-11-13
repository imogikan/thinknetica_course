require_relative 'cargo_trains'
require_relative 'pass_trains'

class TrainWrapper
  def self.create_train(number, type)
    case type
    when :cargo
      CargoTrain.new(number, type)
    when :pass
      PassengerTrain.new(number, type)
    end
  end
end
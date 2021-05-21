# frozen_string_literal: true

module Validate
  module TrainValidate
  end

  def valid?(*params)
    params.each do |param|
      raise '-- invalid params' unless param.presence
    end
  end
end

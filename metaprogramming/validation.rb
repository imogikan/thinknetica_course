module Validation
  def self.included(clazz)
    clazz.send(:extend, ClassMethods)
    clazz.send(:include, Instancemethods)
  end

  module ClassMethods
    attr_accessor :validation

    def validate(name, type, *params)
      @validation ||= []
      @validation << {name: name, type: type, params: params}
    end
  end

  module Instancemethods
    def validate!
      self.class.validation.each do |validation|
        send(validation[:type], instance_variable_get("@#{validation[:name]}".to_sym), validation[:params])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    def presence(name, _params)
      raise if name.nil? || (name.empty? unless name.is_a?(Integer))
    end

    def format(name, params)
      raise unless name =~ params.first
    end

    def check_type(name, params)
      raise unless name.class == params.first
    end
  end
end

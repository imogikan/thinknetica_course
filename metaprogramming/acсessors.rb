require 'pry'

module Accessors
  def self.included(clazz)
    clazz.send(:extend, AccessorsHistory)
    clazz.send(:extend, StrongAccessors)
  end

  module AccessorsHistory
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        var_name = "@#{method}".to_sym
        var_name_history = "@#{method}_history".to_sym

        define_method(method) do
          instance_variable_get(var_name)
        end

        define_method("#{method}_history") do
          instance_variable_get(var_name_history)
        end

        define_method("#{method}=".to_sym) do |value|
          instance_variable_set(var_name, value)

          if instance_variable_get(var_name_history).nil?
            instance_variable_set(var_name_history, [value])
          else
            instance_variable_set(var_name_history,  (instance_variable_get(var_name_history) << value))
          end
        end
      end
    end
  end

  module StrongAccessors
    def strong_attr_accessor(name, clazz)
      var_name = "@#{name}".to_sym

      define_method(name) do
        instance_variable_get(var_name)
      end

      define_method("#{name}=".to_sym) do |value|
        if value.class == clazz
          instance_variable_set(var_name, value)
        else
          raise
        end
      end
    end
  end
end

class Test
  include Accessors

  attr_accessor_with_history :my1, :my2
  strong_attr_accessor :my3, String
  strong_attr_accessor :my4, String

end

test = Test.new
test.my1 = 1
test.my1 = 2
test.my1 = 3
p test.my1_history

test.my4 = "hello"
test.my3 = 1




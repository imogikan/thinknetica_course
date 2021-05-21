# frozen_string_literal: true

module InstanceCounter
  def self.included(clazz)
    clazz.extend(ClassMethods)
    clazz.send(:include, InstanceMethods)
  end

  module ClassMethods
    def instances
      @all_instances.size
    end

    def all_instances
      @all_instances ||= []
      @all_instances
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.all_instances << self
    end
  end
end

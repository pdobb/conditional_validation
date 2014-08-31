module ConditionalValidation
  module ValidationFlag
    extend ActiveSupport::Concern

    module ClassMethods
      # Macro method for defining an attr_accessor and
      # enable/disable/predicate methods that wrap the attr_acessor for
      # determining when to run a set of validation on an ActiveRecord model.
      #
      # @param [*Array] flags the section names for which to define
      #   validation flags for
      #
      # @example
      #   class User
      #     validation_flag :address_attributes
      #   end
      #
      #   # => Defines the following methods on instances of the User class:
      #   #      enable_address_attributes_validation
      #   #      disable_address_attributes_validation
      #   #      validate_on_address_attributes?
      def validation_flag(*flags)
        attr_accessor *flags.map { |flag| "_#{flag}_validation_flag" }

        flags.each do |flag|
          class_eval <<-METHODS, __FILE__, __LINE__ + 1
            def enable_#{flag}_validation
              self._#{flag}_validation_flag = true
              self
            end

            def disable_#{flag}_validation
              self._#{flag}_validation_flag = false
              self
            end

            def validate_on_#{flag}?
              !!_#{flag}_validation_flag
            end
          METHODS
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ConditionalValidation::ValidationFlag)

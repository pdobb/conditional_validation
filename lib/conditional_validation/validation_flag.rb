module ConditionalValidation
  # ConditionalValidation::ValidationFlag is extended by model classes to add
  # the `validation_flag` macro.
  module ValidationFlag
    # Macro method for defining attr_accessor methods, and the associated
    # enable/disable/predicate methods that wrap the attr_acessor methods, for
    # determining when to run validation sets on a model.
    #
    # @param flags [*Array<String>] the validation flag names
    #
    # @example
    #   class User
    #     validation_flag :address_attributes
    #   end
    def validation_flag(*flags)
      raise ArgumentError, "flags can't be empty" if flags.empty?

      accessor_method_names = flags.map { |flag| "_#{flag}_validation_flag" }
      attr_accessor(*accessor_method_names)

      flags.each do |flag|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          # def enable_address_attributes_validation
          def enable_#{flag}_validation
            self._#{flag}_validation_flag = true
            self
          end

          # def disable_address_attributes_validation
          def disable_#{flag}_validation
            self._#{flag}_validation_flag = false
            self
          end

          # def validate_on_address_attributes?
          def validate_on_#{flag}?
            !!_#{flag}_validation_flag
          end
        RUBY
      end
    end
  end
end

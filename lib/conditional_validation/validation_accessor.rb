module ConditionalValidation
  module ValidationAccessor
    extend ActiveSupport::Concern

    module ClassMethods
      # Macro method for defining an attr_accessor and various
      # enable/disable/predicate methods that wrap the attr_acessor for
      # determining when to run a set of validation on an ActiveRecord model.
      #
      # @param args [*accessors] the section names for which to define
      #   validation accessors for
      #
      # @example
      #   class User
      #     validation_accessor :address_attributes
      #   end
      #
      #   # => Defines the following methods on instances of the User class:
      #   #      enable_address_attributes_validation
      #   #      disable_address_attributes_validation
      #   #      validate_on_address_attributes?
      def validation_accessor(*accessors)
        attr_accessor *accessors.map { |accessor|
          "_#{accessor}_validation_accessor"
        }

        accessors.each do |accessor|
          class_eval <<-METHODS, __FILE__, __LINE__ + 1
            def enable_#{accessor}_validation
              self._#{accessor}_validation_accessor = true
              self
            end

            def disable_#{accessor}_validation
              self._#{accessor}_validation_accessor = false
              self
            end

            def validate_on_#{accessor}?
              !!_#{accessor}_validation_accessor
            end
          METHODS
        end
      end
      if ActiveSupport::Deprecation.respond_to?(:new)
        deprecate validation_accessor: :validation_flag,
                  deprecator: ActiveSupport::Deprecation.new('1.0', 'Conditional Validation')
      end
    end
  end
end

ActiveRecord::Base.send(:include, ConditionalValidation::ValidationAccessor)

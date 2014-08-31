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
        attr_accessor *accessors.map { |accessor| "_#{accessor}_validation_accessor" }

        accessors.each do |accessor|
          define_method "enable_#{accessor}_validation" do
            self.send("_#{accessor}_validation_accessor=", true)
            self
          end

          define_method "disable_#{accessor}_validation" do
            self.send("_#{accessor}_validation_accessor=", false)
            self
          end

          define_method "validate_on_#{accessor}?" do
            !!self.send("_#{accessor}_validation_accessor")
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ConditionalValidation::ValidationAccessor)

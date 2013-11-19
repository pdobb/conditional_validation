module ConditionalValidation
  module ValidationAccessor
    extend ActiveSupport::Concern

    module ClassMethods
      # Macro method for defining an attr_accessor and various
      # enable/disable/predicate methods that wrap the attr_acessor for
      # determining when to run a set of validation on an ActiveRecord model.
      # @param args [*section_names] the section names for which to define
      #   validation accessors for
      # @example
      #   class User
      #     validation_accessor :address_attributes
      #   end
      #
      #   # => Defines the following methods on instances of the User class:
      #   #      enable_address_attributes_validation
      #   #      disable_address_attributes_validation
      #   #      validate_on_address_attributes?
      def validation_accessor(*section_names)
        attr_accessor *(section_names.map { |section_name| "validate_on_#{section_name}_attributes" })

        section_names.each do |section_name|
          define_method "enable_#{section_name}_validation" do
            self.send("validate_on_#{section_name}_attributes=", true)
            self
          end

          define_method "disable_#{section_name}_validation" do
            self.send("validate_on_#{section_name}_attributes=", false)
            self
          end

          define_method "validate_on_#{section_name}?" do
            !!self.send("validate_on_#{section_name}_attributes")
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ConditionalValidation::ValidationAccessor)

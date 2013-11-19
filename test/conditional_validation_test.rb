require 'test_helper'

describe ConditionalValidation do
  describe "validation_accessor macro" do
    it "is available to ActiveRecord models" do
      class SomeClass < ActiveRecord::Base
      end
      assert { SomeClass.respond_to?(:validation_accessor) }
    end
  end

  describe "when a model is using the validation_accessor macro" do
    before do
      @user = User.new # Defined in test/dummy app
    end

    it "defines validation_accessor methods" do
      [:enable_address_attributes_validation,
        :disable_address_attributes_validation,
        :validate_on_address_attributes?].each do |method|
        assert { @user.respond_to?(method) }
      end
    end

    it "does not define validation_accessor methods for unrequested validation_accessors" do
      %w[unknown_attributes test2].each do |accessor_name|
        [:"enable_#{accessor_name}_validation",
          :"disable_#{accessor_name}_validation",
          :"validate_on_#{accessor_name}?"].each do |method|
          deny { @user.respond_to?(method) }
        end
      end
    end

    it "allows method chaining when using the getter/setter methods" do
      assert { @user.enable_address_attributes_validation == @user }
      assert { @user.disable_address_attributes_validation == @user }
    end

    describe "conditional validation" do
      it "requests validation when enabled" do
        deny { @user.validate_on_address_attributes? }

        @user.enable_address_attributes_validation
        assert { @user.validate_on_address_attributes? }
      end

      it "does not request validation when disabled again" do
        @user.enable_address_attributes_validation
        assert { @user.validate_on_address_attributes? }

        @user.disable_address_attributes_validation
        deny { @user.validate_on_address_attributes? }
      end
    end
  end
end

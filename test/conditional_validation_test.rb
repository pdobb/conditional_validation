require 'test_helper'

describe ConditionalValidation do
  describe "#validation_accessor" do
    subject { User.new }

    it "is available to ActiveRecord models by default" do
      class SomeClass < ActiveRecord::Base; end
      SomeClass.must_respond_to(:validation_accessor)
    end

    it "defines validation_accessor methods" do
      [:enable_address_attributes_validation,
        :disable_address_attributes_validation,
        :validate_on_address_attributes?].each do |method|
        subject.must_respond_to(method)
      end
    end

    it "does not define validation_accessor methods for unrequested validation_accessors" do
      %w[unknown_attributes test2].each do |accessor_name|
        [:"enable_#{accessor_name}_validation",
          :"disable_#{accessor_name}_validation",
          :"validate_on_#{accessor_name}?"].each do |method|
          subject.wont_respond_to(method)
        end
      end
    end

    describe "validation_accessor methods" do
      it "allows method chaining" do
        subject.enable_address_attributes_validation.must_equal subject
        subject.disable_address_attributes_validation.must_equal subject
      end

      it "requests validation when enabled" do
        refute subject.validate_on_address_attributes?

        subject.enable_address_attributes_validation
        assert subject.validate_on_address_attributes?
      end

      it "does not request validation when disabled again" do
        subject.enable_address_attributes_validation
        assert subject.validate_on_address_attributes?

        subject.disable_address_attributes_validation
        refute subject.validate_on_address_attributes?
      end
    end
  end
end

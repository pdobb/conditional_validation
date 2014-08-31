require 'test_helper'

describe ConditionalValidation do
  describe "#validation_flag" do
    # User is defined in test/dummy/app/models/user.rb and is setup with
    # validation_flags already.
    subject { User.new }

    it "is available to ActiveRecord models by default" do
      class SomeClass < ActiveRecord::Base; end
      SomeClass.must_respond_to(:validation_flag)
    end

    it "defines validation_flag methods" do
      [:enable_flag_attributes_validation,
        :disable_flag_attributes_validation,
        :validate_on_flag_attributes?].each do |method|
        subject.must_respond_to(method)
      end
    end

    it "does not define validation_flag methods for unrequested validation_flags" do
      [:"enable_unknown_attributes_validation",
        :"disable_unknown_attributes_validation",
        :"validate_on_unknown_attributes?"].each do |method|
        subject.wont_respond_to(method)
      end
    end

    describe "validation_flag methods" do
      it "allows method chaining" do
        subject.enable_flag_attributes_validation.must_equal subject
        subject.disable_flag_attributes_validation.must_equal subject
      end

      it "requests validation when enabled" do
        refute subject.validate_on_flag_attributes?

        subject.enable_flag_attributes_validation
        assert subject.validate_on_flag_attributes?
      end

      it "does not request validation when disabled" do
        subject.enable_flag_attributes_validation
        assert subject.validate_on_flag_attributes?

        subject.disable_flag_attributes_validation
        refute subject.validate_on_flag_attributes?
      end
    end
  end

  describe "#validation_accessor" do
    # User is defined in test/dummy/app/models/user.rb and is setup with
    # validation_flags already.
    subject { User.new }

    it "is available to ActiveRecord models by default" do
      class SomeClass < ActiveRecord::Base; end
      SomeClass.must_respond_to(:validation_accessor)
    end

    it "defines validation_accessor methods" do
      [:enable_accessor_attributes_validation,
        :disable_accessor_attributes_validation,
        :validate_on_accessor_attributes?].each do |method|
        subject.must_respond_to(method)
      end
    end

    it "does not define validation_accessor methods for unrequested validation_accessors" do
      [:"enable_unknown_attributes_validation",
        :"disable_unknown_attributes_validation",
        :"validate_on_unknown_attributes?"].each do |method|
        subject.wont_respond_to(method)
      end
    end

    describe "validation_accessor methods" do
      it "allows method chaining" do
        subject.enable_accessor_attributes_validation.must_equal subject
        subject.disable_accessor_attributes_validation.must_equal subject
      end

      it "requests validation when enabled" do
        refute subject.validate_on_accessor_attributes?

        subject.enable_accessor_attributes_validation
        assert subject.validate_on_accessor_attributes?
      end

      it "does not request validation when disabled" do
        subject.enable_accessor_attributes_validation
        assert subject.validate_on_accessor_attributes?

        subject.disable_accessor_attributes_validation
        refute subject.validate_on_accessor_attributes?
      end
    end
  end
end

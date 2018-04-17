require "test_helper"

class ConditionalValidation::ValidationFlagTest < Minitest::Spec
  class TestModel
    extend ConditionalValidation::ValidationFlag

    validation_flag :test_attributes
  end

  describe ConditionalValidation::ValidationFlag do
    let(:klazz) { ConditionalValidation::ValidationFlag }

    describe ".validation_flag" do
      subject { TestModel.new }

      it "defines validation_flag methods" do
        %i[
          enable_test_attributes_validation
          disable_test_attributes_validation
          validate_on_test_attributes?
        ].each do |method|
          subject.must_respond_to(method)
        end
      end

      it "raises ArgumentError, GIVEN no flags" do
        -> { class TestModel; validation_flag; end }.must_raise ArgumentError
      end
    end

    describe "#enable_<flag>_attributes" do
      subject { TestModel.new }

      it "allows method chaining" do
        subject.enable_test_attributes_validation.must_equal subject
      end

      it "enables validation" do
        subject.validate_on_test_attributes?.must_equal false
        subject.enable_test_attributes_validation
        subject.validate_on_test_attributes?.must_equal true
      end
    end

    describe "#disable_<flag>_attributes" do
      subject { TestModel.new }

      it "allows method chaining" do
        subject.disable_test_attributes_validation.must_equal subject
      end

      it "disables validation" do
        subject.enable_test_attributes_validation
        subject.validate_on_test_attributes?.must_equal true

        subject.disable_test_attributes_validation
        subject.validate_on_test_attributes?.must_equal false
      end
    end
  end
end

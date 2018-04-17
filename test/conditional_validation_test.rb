require "test_helper"

class ConditionalValidationTest < Minitest::Spec
  describe ConditionalValidation do
    let(:klazz) { ConditionalValidation }

    it "has a VERSION" do
      klazz::VERSION.wont_be_nil
    end
  end
end

require 'test_helper'
include EyeTV

class RbEyetvTest < Test::Unit::TestCase
  context "EyeTV application" do
    setup do
      @instance = EyeTV::EyeTV.new
    end
    should "not recording" do
      assert !(@instance.is_recording?)
    end
  end
end

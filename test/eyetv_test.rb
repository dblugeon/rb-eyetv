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

    should "find an channel or nil" do
      if !(@instance.channels.empty?)
        uid = @instance.channels[0].channel_number
        chan = @instance.find_by_id(:channel, uid)
        assert chan.instance_of?(EyeTV::Channel), "actual class = #{chan.class.to_s}"
      end
    end

    should "find an recording or nil" do
      if !(@instance.recordings.empty?)
        uid = @instance.recordings[0].uid
        record = @instance.find_by_id(:recording, uid)
        assert record.instance_of?(EyeTV::Recording), "actual class = #{record.class.to_s}"
      end
    end

    should "find an program or nil" do
      if !(@instance.programs.empty?)
        uid = @instance.programs[0].uid
        program = @instance.find_by_id(:program, uid)
        assert program.instance_of?(EyeTV::Program), "actual class = #{program.class.to_s}"
      end
    end
  end
end

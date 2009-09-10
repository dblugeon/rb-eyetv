require 'test_helper'
include EyeTV

class RbEyetvTest < Test::Unit::TestCase
  context "EyeTV application" do
    setup do
      @instance = EyeTV::EyeTV.new
      if @instance.programs(true).empty?
        @program_test = @instance.make_program({:start_time => Time.now + 3600, :duration => 3600, :title => "program unit test"})
        @clean_program = true
      else
        @program_test = @instance.programs(true)[0]
      end
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

    should "check check_program method with conflict program" do
      assert_not_nil @instance.check_program({:start_time=>@program_test.start_time, :duration=>@program_test.duration})
    end

    should "check check_program method without conflict program" do
      tmp_progs = @instance.programs(true).sort do |prog|
        prog.start_time
      end
      prog = tmp_progs.last
      assert_nil @instance.check_program({:start_time => prog.end_time + 200, :duration => prog.duration})
    end

    teardown do
      if @clean_program
        @program_test.delete
      end
    end
  end
end

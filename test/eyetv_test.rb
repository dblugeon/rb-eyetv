require 'test_helper'
include EyeTV
include Appscript
class RbEyetvTest < Test::Unit::TestCase
  context "EyeTV application" do
    setup do
      @instance = EyeTV::EyeTV.new
      @instance_ref = app('EyeTV')
      if @instance.programs(true).empty?
        @program_test = @instance.make_program({:start_time => Time.now + 3600, :duration => 3600, :title => "program unit test"})
        @clean_program = true
      else
        @program_test = @instance.programs(true)[0]
      end
    end
    
    should "test is_recording? method" do
      assert_equal @instance_ref.is_recording.get, @instance.is_recording?
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
      tmp_progs = @instance.programs(true).sort do |progA, progB|
        progA.start_time <=> progB.start_time
      end
      prog = tmp_progs.last
      assert_nil @instance.check_program({:start_time => prog.end_time + 200, :duration => prog.duration})
    end

    should "test make_program method with conflict program" do
      assert_raise ConflictProgramException do
        @r2 = @instance.make_program({:start_time=>@program_test.start_time, :duration=>@program_test.duration})
      end
    end

    should "test make_program 2 method with conflict program" do
     begin
        @r3 = @instance.make_program({:start_time=>@program_test.start_time, :duration=>@program_test.duration})
      rescue ConflictProgramException =>e
        assert_not_nil e.program_exist
      end
    end

    should "test current_channel_number" do
      assert_equal @instance_ref.current_channel.get, @instance.current_channel_number
    end

    teardown do
      if @clean_program
        @program_test.delete
      end
      
      if @r2
        @r2.delete
      end
      
      if @r3
        r3.delete
      end
    end
  end
end

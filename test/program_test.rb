require 'test_helper'
include EyeTV

class RbProgramTest < Test::Unit::TestCase
  context "EyeTV Program" do
    setup do
      @instance = EyeTV::EyeTV.new
      if @instance.programs(true).empty?
        @program_test = @instance.make_program({:start_time => Time.now + 3600, :duration => 3600, :title => "program unit test"})
        @clean_program = true
      else
        @program_test = @instance.programs(true)[0]
      end
    end
    
    should "test raise exception in input_source= method" do
      assert_raise RuntimeError do
        @program_test.input_source = DateTime.new
      end
    end

    should "test raise exception in repeats= method" do
      assert_raise RuntimeError do
        @program_test.repeats = "never1"
      end
    end

    should "test raise exception in quality= method" do
      assert_raise RuntimeError do
        @program_test.quality = "hight2"
      end
    end

    should "test raise exception in start_time= method" do
      assert_raise RuntimeError do
        @program_test.start_time = DateTime.new
      end
    end

    should "test raise exception in channel_number= method with string" do
      assert_raise RuntimeError do
        @program_test.channel_number = "sqdqs"
      end
    end

    should "test raise exception in channel_number= method with 12000 channel" do
      assert_raise RuntimeError do
        @program_test.channel_number = "12000"
      end
    end

    should "end_time must be equals to start_time + duration" do
      assert_equal (@program_test.start_time + @program_test.duration), @program_test.end_time
    end
    
    should "program must conflict" do
      test_start_time = @program_test.start_time + 200
      duration = 1000

      assert @program_test.conflict?(test_start_time, duration)
      
      test_start_time = @program_test.start_time - 100

      assert @program_test.conflict?(test_start_time, duration)
      
      test_start_time = @program_test.end_time - 250
      
      assert @program_test.conflict?(test_start_time, duration)
    end
    
    should "program should not conflict" do
      test_start_time = @program_test.start_time - 1500
      duration = 1000

      assert !@program_test.conflict?(test_start_time, duration)

      test_start_time = @program_test.start_time + 200
      duration = 1000

      assert !@program_test.conflict?(test_start_time, duration, @program_test.uid)
    end
    
    teardown do
      if @clean_program
        @program_test.delete
      end
    end
  end
end

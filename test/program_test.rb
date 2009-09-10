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
      
      test_start_time = @program_test.end_time + 500
    end
    
    teardown do
      if @clean_program
        @program_test.delete
      end
    end
  end
end

#This module permit to control the EyeTV application with applescript bridge
module EyeTV
  #This class represents an instnace of schedule Program on EyeTV
  class Program

    @@repeats_possible = [:never,:none,:daily,:weekdays,:weekends]
    @@qualities_possible = [:standard, :high]
    @@input_sources_possible = [:tuner_input, :composite_video_input, :S_video_input]
    
    def initialize(program_instance)
      @program_ref = program_instance      
    end
    
    def uid
      @program_ref.unique_ID.get
    end

    def start_time
      @program_ref.start_time.get
    end

    def start_time=(new_start_time)
      raise "Must be an datetime objet" if not new_start_time.is_a?(Time)
      @program_ref.start_time.set(new_start_time)
    end

    def duration
      @program_ref.duration.get
    end

    def duration=(new_duration)
      @program_ref.duration.set(new_duration)
    end

    #calculate the end time of program
    def end_time
      start_time + duration
    end

    #test if the parameters enter in conflict with a program instance
    def conflict?(test_start_time, nduration)
      nend_time = test_start_time + nduration
      if nend_time < start_time or end_time < test_start_time
        conflict = false
      else
        conflict = true
      end
    end

    def title
      @program_ref.title.get
    end

    def title=(new_title)
      @program_ref.title.set(new_title)
    end

    def description
      @program_ref.description.get
    end

    def description=(new_description)
      @program_ref.description.set(new_description)
    end

    def channel_number
      @program_ref.channel_number.get
    end

    def channel_number=(new_channel_number)
      @program_ref.channel_number.set(new_channel_number)
    end

    def self.input_sources_possible
      @@input_sources_possible
    end

    def input_source
      @program_ref.input_source.get
    end

    def input_source=(new_input_source)
      raise "bad value for input_source" if !new_input_source.respond_to?(:to_sym) or not @@input_sources_possible.include?(new_input_source.to_sym)
      @program_ref.input_source.set(new_input_source.to_sym)
    end

    def self.repeats_possible
      @@repeats_possible
    end

    def repeats
      @program_ref.repeats.get
    end

    def repeats=(new_repeats)
      raise "bad value for repeats" if !new_repeats.respond_to?(:to_sym) or not @@repeats_possible.include?(new_repeats.to_sym)
      @program_ref.repeats.set(new_repeats.to_sym)
    end

    def self.qualities_possible
      @@qualities_possible
    end

    def quality
      @program_ref.quality.get
    end

    def quality=(new_quality)
      raise "bad value for quality" if !new_quality.respond_to?(:to_sym) or not @@qualities_possible.include?(new_quality.to_sym)
      @program_ref.quality.set(new_quality.to_sym)
    end

    def enabled?
      @program_ref.enabled.get
    end

    def enabled(value)
      @program_ref.enabled.set(value)
    end

    def delete
      @program_ref.delete
    end

    def to_s
      self.title.concat("; start : ").concat(self.start_time.to_s).concat("; duration : ").
        concat(self.duration.to_s).concat("; on channel : ").concat(self.channel_number.to_s)
    end
  end
end
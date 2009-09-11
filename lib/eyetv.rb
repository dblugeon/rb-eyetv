require 'rubygems'
require "appscript"
require 'Channel'
require 'Program'
require 'Recording'
include Appscript

#This module permit to control the EyeTV application with applescript bridge
module EyeTV
  #This is the main Class of this module
  class EyeTV    

    def initialize
      @instance = app('EyeTV')
      unless @instance.is_running?
        launch
      end
    end

    def channels
      chans = []
      @instance.channels.get.each do |chan|       
        chans.push(Channel.new(chan))
      end
      chans
    end

    #return program list, the only_future option indiquate if the future programs must be returned
    def programs(only_future = true)
      programs_tab = []
      @instance.programs.get.each do |prog|
        if !only_future or prog.start_time.get > Time.now
          programs_tab.push(Program.new(prog))
        end
      end
      programs_tab
    end

    #return recording list
    def recordings
      recordings =[]
      @instance.recordings.get.each do |recording|
        recordings.push(Recording.new(recording))
      end
      recordings
    end

    #close EyeTV Application
    def quit
      @instance.quit
    end

    #launch EyeTV application
    def launch
      @instance.launch
    end

    #restart the EyeTV
    def restart
      @instance.quit
      @instance.launch
    end

    #flag indicate if EyeTv record an Program
    def is_recording?
      @instance.is_recording.get
    end

    #return the current channel
    def current_channel_number
      @instance.current_channel.get
    end

    #return an channel, program or recording with the id
    #work with following symbols : :channel :program :recording
    def find_by_id(type, id)
      if id != nil
        case type
        when :channel
          channels.find{|chan| chan.channel_number == id}
        when :program
          programs.find{|obj| obj.uid == id}
        when :recording
          recordings.find{|obj| obj.uid == id}
        end
      end
    end

    #create a program with options 
    #a nil option launch a live record 
    #example : 
    #a = EyeTV.new() 
    #p = a.make_program(:channel_number => 3, :start_time => Time.now + 120 seconds, :title => "Knight Rider", :duration => 3600, :quality => :hight) 
    #return an Program instance 
    #throw a ConflictProgramException if there is a "time conflict" with the :start_time and the :duration option

    def make_program(options = {})
        program = check_program(options)
        if program != nil
          puts "program = #{program.to_s}"
          raise ConflictProgramException.new(program)
        end
        record = Program.new(@instance.make(:new =>:program, :with_properties => options))
    end

    #check options for make a program
    #return an program instance if a conflict is detected
    #if no conflict founded, return nil

    def check_program(options={})
      if(options[:duration] == nil)
        options[:duration] = 10800
      end
      if(options[:start_time] == nil)
        options[:start_time] = Time.now
      end
      res = nil
      programs(true).each do |prog|
        if(res == nil and prog.conflict?(options[:start_time], options[:duration]))
          res = prog
        end
      end
      res
    end
  end

  #Exception can be throw by the make_program from EyeTV class
  class ConflictProgramException < Exception
    #return the program in conflict
    attr_reader :program_exist

    def initialize(program)
      @program_exist = program
    end
  end


  if __FILE__ == $0
    puts "start Eyetv"
    etv = EyeTV.new
    puts "channels numbers : #{etv.channels.size}"
    etv.channels.each do |chan|
      if chan.enabled?
        chan.enabled = false
        puts "#{chan} désactivé"
      else
        chan.enabled = true
        puts "#{chan} activé"
      end      
    end
    etv.programs.each do |program|
      puts program
    end

    etv.recordings.each do |record|
      puts record
    end
    puts "enregistrement en cours : #{etv.is_recording?}"
    puts "done"
  end
end
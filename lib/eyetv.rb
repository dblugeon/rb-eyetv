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

    def programs
      programs_tab = []
      @instance.programs.get.each do |prog|
        programs_tab.push(Program.new(prog))
      end
      programs_tab
    end

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

    def current_channel_number
      @intance.current_channel.get
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
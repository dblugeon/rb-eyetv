#This module permit to control the EyeTV application with applescript bridge
module EyeTV
  #This is the class channel of EyeTv
  #You can (des)activate an channel
  class Channel    
    attr_reader :channel_number        

    def initialize(chan_ref)
      raise "must no nil object" if(not chan_ref)        
      @chan_ref = chan_ref
    end

    def name
      @chan_ref.name.get
    end

    def name=(new_name)
      @chan_ref.name.set(new_name)
    end

    def channel_number
      @chan_ref.channel_number.get
    end

    def channel_number=(new_channel_number)
      @chan_ref.channel_number.set(new_channel_number)
    end

    # return true if action is possible
    def enabled=(value)
      if @chan_ref && value !=nil
        @chan_ref.enabled.set(value)
        true
      else
        false
      end      
    end

    def enabled?
      if @chan_ref
        @enabled = @chan_ref.enabled.get
      end
      @enabled
    end

    def delete
      @chan_ref.delete
    end

    def to_s
      self.channel_number().to_s.concat(" ").concat(self.name()).concat(" ").concat(self.enabled?.to_s)
    end
  end
end
#This module permit to control the EyeTV application with applescript bridge
module EyeTV
  #This class represents an recording (audio or video) product by EyeTV
  class Recording
    def initialize(recording_ref)
      @recording_ref = recording_ref
    end

    def busy?
      @recording_ref.busy.get
    end
    
    def start_time
      @recording_ref.start_time.get
    end

    def duration
      @recording_ref.duration.get
    end   

    def title
      @recording_ref.title.get
    end

    def title=(title)
      @recording_ref.title.set(title)
    end

    def description
      @recording_ref.description.get
    end

    def description=(new_description)
      @recording_ref.description.set(new_description)
    end

    def channel_number
      @recording_ref.channel_number.get
    end

    def station_name
      @recording_ref.station_name.get
    end
    
    def input_source
      @recording_ref.input_source.get
    end
    
    def repeats
      @recording_ref.repeats.get
    end

    def quality
      @recording_ref.quality.get
    end

    def prepad_time
      @recording_ref.prepad_time.get
    end

    def postpad_time
      @recording_ref.postpad_time.get
    end

    def actual_start
      @recording_ref.actual_start.get
    end

    def actual_duration
      @recording_ref.actual_duration.get
    end

    def playback_position
      @recording_ref.actual_duration.get
    end

    def playback_position=(new_playback_position)
      @recording_ref.actual_duration.set(new_playback_position)
    end
    
    def name
      @recording_ref.name.get
    end

    def name=(value)
      @recording_ref.name.set(value)
    end

    def episode
      name
    end

    def episode=(value)
      self.name = value
    end

    def uid
      @recording_ref.unique_ID.get
    end

    def location
      @recording_ref.location.get
    end
    
    def preview_picture
      @recording_ref.preview_picture.get
    end

    def markers
      @recording_ref.markers.get
    end
    
    def delete
      @recording_ref.delete
    end

    def to_s
      "uid : ".concat(self.uid.to_s).concat("; title : ").concat(self.title)
    end
  end
end
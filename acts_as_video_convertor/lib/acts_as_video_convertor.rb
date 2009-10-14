module ActsAsVideoConvertor
  DEFAULT_VIDEO_PATH = "public/video/video_data/"
  def self.video_convertor(upload)
    full_name =  upload.video_data
    name = get_file_name_from_path(full_name)
    directory = DEFAULT_VIDEO_PATH+upload.id.to_s
    path = File.join(directory, name)
    if !name.nil?
      convert_video_to_flv(path,name, directory)
    end
  end

  def self.convert_video_to_flv(path,video_file_name,video_id)
    memdir =RAILS_ROOT + '/vendor/plugins/acts_as_video_convertor/mplayer/'
    name = parse_file_name(video_file_name)
    opdir = RAILS_ROOT + "/#{video_id}/"+name+".flv"
    filepath = RAILS_ROOT + "/#{video_id}/"+video_file_name
    begin
      system "#{memdir}mencoder #{filepath} -o #{opdir}  -of lavf -oac mp3lame -lameopts abr:br=56 -srate 22050 -ovc lavc -lavcopts vcodec=flv:vbitrate=500:mbd=2:mv0:trell:v4mv:cbp:last_pred=3 -lavfopts i_certify_that_my_video_stream_does_not_use_b_frames"
      @file = File.delete(filepath)
      res = get_snapshot(memdir,opdir,name,video_id)
    rescue IOException
      raise IOException
    end
  end

  def self.get_snapshot(memdir,opdir,name,video_id)
    image_dir = RAILS_ROOT + "/#{video_id}/"+name
    system "#{memdir}ffmpeg -i #{opdir} -s 320x240 -vframes 1 -f image2 -an #{image_dir}.jpg"
    return true
  end
 
  def self.parse_file_name(video_file_name)
    name_array = video_file_name.split(".")
    name = ""
    0.step(name_array.length-2,1) do |name_index|
      name += name_array[name_index]
    end
    return name
  end
  
  def self.get_file_name_from_path(full_name)
    name_array = full_name.split("/")
    name = name_array[name_array.length-1]
    return name
  end
  
  
end
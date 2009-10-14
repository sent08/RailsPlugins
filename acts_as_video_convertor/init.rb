# Include hook code here
require 'acts_as_video_convertor'
require 'video_file_column'
require 'video_file_column_helper'

ActiveRecord::Base.send(:include, VideoFileColumn)
ActionView::Base.send(:include, VideoFileColumnHelper)

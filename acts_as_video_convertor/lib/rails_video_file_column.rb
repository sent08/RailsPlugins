# require this file from your "config/environment.rb" (after rails has been loaded)
# to integrate the video_file_column extension into rails.

require 'video_file_column'
require 'video_file_column_helper'


module ActiveRecord # :nodoc:
  class Base # :nodoc:
    # make video_file_column method available in all active record decendants
    include VideoFileColumn
  end
end

module ActionView # :nodoc:
  class Base # :nodoc:
    include VideoFileColumnHelper
  end
end

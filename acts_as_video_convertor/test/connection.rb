print "Using native MySQL\n"
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

db = 'video_file_column_test'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :host     => "localhost",
  :username => "rails",
  :password => "",
  :database => db,
  :socket => "/var/run/mysqld/mysqld.sock"
)

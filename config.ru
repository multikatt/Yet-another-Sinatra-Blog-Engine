# http://stackoverflow.com/questions/4346981/issues-with-sinatra-and-ruby-1-9-2-on-shotgun
path = File.expand_path "../", __FILE__

require "rubygems"
require "sinatra"
require "sinatra/flash"
require "data_mapper"
require "haml"
require "#{path}/blog.rb"
require "#{path}/mdfilter.rb"

if ENV['RACK_ENV'] == 'production'
  set :enviroment, :production
  set :port, 4567
  disable :run, :reload
end

run Sinatra::Application

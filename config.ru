require 'rubygems'
require 'sinatra'
 
root_dir = File.dirname(__FILE__)
 
set :environment, :production
disable :run

set :views, File.join(root_dir, 'views')
#set :app_file, File.join(root_dir, 'shortener.rb')

require 'shortener.rb'

run Sinatra::Application

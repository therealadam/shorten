require 'shortener'

set :environment, :production
set :root, File.dirname(__FILE__)

run Sinatra::Application

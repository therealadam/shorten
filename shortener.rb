$LOAD_PATH << File.join(Dir.getwd, 'lib')
require 'rubygems'
require 'sinatra'
require 'shorten'

before do
  @shorten = Shortener.load
end

helpers do

  def base_url
    base = "http://#{Sinatra::Application.host}"
    port = Sinatra::Application.port == 80 ? base : base <<
":#{Sinatra::Application.port}"
  end

  def url(path='')
    [base_url, path].join('/')
  end

end

get '/' do
  erb :home
end

post '/shorten' do
  url = @shorten.shorten(params['url'])
  redirect "/info/#{url.hash}"
end

get '/info/:hash' do
  url = @shorten.lookup(params[:hash])
  erb :shortened, :locals => {:url => url}
end

get '/:hash' do
  url = @shorten.lookup(params[:hash])
  redirect url.url
end





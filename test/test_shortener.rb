require 'rubygems'
require 'sinatra/test/unit'
require File.join(File.dirname(__FILE__), '..', 'shortener')

class TestShortener < Test::Unit::TestCase
  
  configure do
    set :views => File.join(File.dirname(__FILE__), '..',
'views')
  end

  def test_home_renders_content
    get '/'
    
    assert_equal 200, @response.status
    assert @response.body.length > 0
  end
  
  def test_shorten_redirects_to_info
    post '/shorten', {:url => 'example.com'}
    assert_equal 302, @response.status
    assert_match %r{/info/.*}, @response['Location']
  end
  
end

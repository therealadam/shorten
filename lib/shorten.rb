require 'time'
require 'digest/sha1'

require 'rubygems'

gem 'json'
require 'json'

class Shortener
  def self.load
    obj = self.new
    obj.load
    return obj
  end
  
  def self.shorten(url)
    load.shorten(url)
  end
  
  attr_reader :store, :urls
  
  def initialize(store='shorten.json')
    @store = store
  end
  
  def load
    @urls = load_json(store)
  end
  
  def shorten(url)
    return @urls[hash] if @urls.has_key?(hash)
    hash = hash_for(url)
    store_hash(Url.build(url, hash), hash)
  end
  
  def lookup(hash)
    @urls[hash]
  end
  
  def recent
    urls.values.sort_by { |u| u.timestamp }
  end
  
  private
  
  def hash_for(url)
    Digest::SHA1.hexdigest(url)
  end
  
  module JsonStore
    
    private
    
    def load_json(path)
      json = begin
        File.read(path) 
      rescue Errno::ENOENT
        '{}'
      end
      JSON.load(json).inject({}) do |urls, record|
        url = Url.new(record['url'], record['hash'])
        url.timestamp = Time.parse(record['timestamp'])
        urls.update(url.hash => url)
      end
    end
    
    def save_json
      json = @urls.map { |(hash, url)| url.to_json }.to_json
      File.open(store, 'w') { |f| f.write(json) }
    end
    
    def store_hash(url, hash)
      @urls[hash] = url
      save_json
      url
    end
    
  end
  
  include JsonStore
  
  class Url
    attr_accessor :url, :hash, :timestamp
    
    def self.build(url, hash)
      obj = Url.new(url, hash)
      obj.timestamp = Time.now
      return obj
    end
    
    def initialize(url, hash)
      @url, @hash = url, hash
    end
    
    def to_json
      {'url' => url, 'hash' => hash, 'timestamp' => timestamp.to_json}
    end
    
  end
  
end

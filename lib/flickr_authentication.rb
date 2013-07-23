require "flickr_authentication/version"
require 'flickraw'
require 'launchy'
require 'yaml'

class FlickrAuthentication

  attr_accessor :key, :shared_secret, :auth_file

  def initialize(options = {})
    @key           = options[:key]
    @shared_secret = options[:shared_secret]
    @auth_file     = options[:auth_file]
  end

  def authenticate
    FlickRaw.api_key        = key
    FlickRaw.shared_secret  = shared_secret

    if File.exists?(auth_file)
      puts "authenticating with #{auth_file}"
      data = YAML.load_file(auth_file)
      auth = flickr.auth.checkToken :auth_token => data["api_token"]
    else
      frob      = flickr.auth.getFrob
      auth_url  = FlickRaw.auth_url :frob => frob, :perms => "write"

      puts " "
      puts "opening your browser..."
      sleep 1
      puts "Come back and press Enter when you are finished"
      sleep 2
      Launchy.open(auth_url)

      STDIN.getc

      # Authentication
      auth  = flickr.auth.getToken :frob => frob
      login = flickr.test.login

      puts auth.token
      data              = {}
      data["api_token"] = auth.token
      File.open(auth_file, "w"){|f| YAML.dump(data, f) }
    end

    flickr #return the flickr object

  end

end

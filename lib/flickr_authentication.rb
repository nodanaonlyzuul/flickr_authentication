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

      flickr.access_token   = data['access_token']
      flickr.access_secret  = data['access_secret']

      begin
        flickr.test.login
      rescue Exception => e
        puts "There are bad credentials in #{@auth_file}. Delete it and try again."
      end

    else
      token    = flickr.get_request_token
      auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'write')

      puts " "
      puts "opening your browser..."
      sleep 1
      puts "Come back and press enter the given number when you are finished"
      sleep 2
      Launchy.open(auth_url)

      verify = gets.strip

      begin
        flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
        login = flickr.test.login
        puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
        # Write the YML File
        data = {}
        data["access_token"]  = flickr.access_token
        data["access_secret"] = flickr.access_secret
        File.open(auth_file, "w"){|f| YAML.dump(data, f) }
      rescue FlickRaw::FailedResponse => e
        puts "Authentication failed : #{e.msg}"
      end
    end

    flickr #return the flickr object

  end

end

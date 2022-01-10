# FlickrAuthentication

A library for authentication your application via Flickr's API.
It uses the wonderful [flickraw](http://hanklords.github.io/flickraw/) library.

## Resources

-   [Applying for a Flickr API](http://www.flickr.com/services/apps/create/apply)
-   [Flickr API documentation](http://www.flickr.com/services/api/)

## Usage

    flickr_authentication = FlickrAuthentication.new(key: "YOURKEYHERE", shared_secret: "APPSSHAREDSECRET", auth_file: "path/to/file/where/credentials/are/stored")
    flickr                = flickr_authentication.authenticate
    #flickr is defined by flickraw

For more example usage see the code for [flickr_airlift](https://github.com/nodanaonlyzuul/flickr_airlift) and [flickr_cli](https://github.com/nodanaonlyzuul/flickr_cli).

## Contributing

1.  Fork it
2.  Create your feature branch (`git checkout -b my-new-feature`)
3.  Commit your changes (`git commit -am 'Add some feature'`)
4.  Push to the branch (`git push origin my-new-feature`)
5.  Create new Pull Request

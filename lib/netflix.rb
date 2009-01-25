$:.unshift File.dirname(__FILE__)

require "hpricot"
require "oauth/consumer"
require "oauth/token"

require "netflix/user"
require "netflix/client"
require "netflix/configuration"
require "netflix/response"

# patch the request token class to play better with netflix
require "oauth/patches/token"

$:.unshift File.dirname(__FILE__)

require "hpricot"
require "oauth/consumer"
require "oauth/token"

require "netflix/api_request"
require "netflix/api_response"
require "netflix/client"
require "netflix/configuration"
require "netflix/user"
# patch the request token class to play better with netflix
require "oauth/patches/token"

# -*- coding: utf-8 -*-
require "open-uri"
require "oauth"
require "oauth/patches/token"

module Netflix
    
  # wrap exceptions as our own.
  class ClientError < StandardError; end  

  # Client class responsible for setting up api calls.
  class Client
    
    class << self
      
      # factory that returns a new client instance but yields a config
      # object first so that the user can set config properties first.
      # TODO: try to eval this block on Netflix::Configuration
      # so we only have to reference the setters by name
      def configure(&blk)
        blk.call(Netflix::Configuration) if block_given?
        new
      end
    end
    
    def initialize; end    

    def begin_verification(callback_url, &blk)
      request_token = Netflix::Configuration.build_consumer.get_request_token
      callback_url = request_token.authorize_url(
       :oauth_consumer_key => Netflix::Configuration.build_consumer.key,
       :application_name   => Netflix::Configuration.application_name,
       :oauth_callback     => callback_url);
      blk.call(request_token.token, request_token.secret, callback_url)
    end
   
    # assuming we have stored these somewhere temporarily
    # (request tokens/secrets are transient and cannot be reused. put
    # it in the session or some other store. drop them once you hav
    # exchanged it for an access token)
    # client.finalize_verification(rt, rs) do |api|
    #   api.get "/queue"
    #   access_token_key = api.access_token_key
    #   access_token_secret = api.access_token_secret
    #   user_id = api.user_id
    # end
    def finalize_verification(request_token, request_token_secret, &blk)
      access_token = build_access_token_from_request_token(request_token, request_token_secret)
      self.api_request = build_api_request(access_token.token, access_token.secret)
      # TODO: move this to the api_request class so getting the user
      # can be easily repeatable.
      current_user = self.api_request.get("/users/current")
      user_href = current_user.at("/resource/link")["href"]
      user_id = self.api_request.get(user_href).at("/user/user_id")
      blk.call(self.api_request, user_id) if block_given?
      self.api_request
    end

    # At this point we can try to make api calls.
    # We have either:
    # * Just proved that we are who we are in netflix
    # * Retrieved the access token info form a datastore
    def api(access_token, access_token_secret, &blk)
      self.api_request = build_api_request(access_token, access_token_secret)
      blk.call(self.api_request) if block_given?
      self.api_request
    end
    
    protected

    attr_accessor :api_request
    
    def build_api_request(token, secret)
      if token.nil? or token.empty? or secret.nil? or secret.empty?
        raise Netflix::ClientError.new
      end
      @api_request ||= begin
        access_token = OAuth::AccessToken.new(                 
          Netflix::Configuration.consumer,
          token,                                    
          secret)                                    
        Netflix::ApiRequest.new(access_token)
      end
    end

    def build_access_token_from_request_token(token, secret)
      OAuth::RequestToken.new(
        Netflix::Configuration.build_consumer,
        token,
        secret).get_access_token
    end
    
  end
   
end

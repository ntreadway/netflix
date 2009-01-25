# -*- coding: utf-8 -*-
require "open-uri"

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
        blk.call Netflix::Configuration if block_given?
        new
      end
    end
    
    def initialize; end    

    def begin_verification(callback_url, &blk)
      request_token = consumer.get_request_token
      callback_url = request_token.authorize_url(
       :oauth_consumer_key => consumer.key,
       :application_name   => Netflix::Configuration.application_name,
       :oauth_callback     => callback_url);
      blk.call request_token.token, request_token.secret, callback_url
      self
    end
   
    # assuming we have stored these somewhere temporarily
    # (request tokens/secrets are transient and cannot be reused. put
    # it in the session or some other store. drop them once you hav
    # exchanged it for an access token)
    # client.finalize_verification(rt, rs) do |token, secret, user_id|
    #   config.get "/queue"
    # end
    def finalize_verification(request_token, request_token_secret, &blk)
      self.access_token = OAuth::RequestToken.new(
        consumer,
        request_token,
        request_token_secret).get_access_token
      current_user = get "/users/current"
      user_href = current_user.at("/resource/link")["href"]

      blk.call(access_token.token, access_token.secret, user_id)
      self
    end

    # At this point we can try to make api calls.
    # We have either:
    # * Just proved that we are who we are in netflix
    # * Retrieved the access token info form a datastore
    def api(access_token, access_token_secret, &blk)
      access_token = build_access_token(access_token, access_token_secret)
      instance_eval(blk) if block_given?
      self
    end

    # TODO: always force gzip in the following
    # calls. {"Accept-Encoding" => "compress"}
    def get(url, *args)
      access_token_guard! do
        self.access_token.get url, args
      end  
    end

    def post(url, *args)
      access_token_guard! do
        self.access_token.post url, args      
      end
    end

    def delete(url, *args)
      access_token_guard! do
        self.access_token.delete url, args
      end
    end
    
    private

    attr_accessor :access_token
    
    def build_access_token(token, secret)
      self.access_token ||= OAuth::AccessToken.new(
        consumer,
        token,
        secret)
    end
     
    def consumer
      @consumer ||= OAuth::Consumer.new(
         Netflix::Configuration.consumer_token,
         Netflix::Configuration.consumer_secret,
         Netflix::Configuration.api_options)
    end
    
    # assert that the client has an access token before making api calls.
    def access_token_guard!(&blk)
      if access_token.nil?
        raise ClientError.new("An OAuth access token is required to access the api.")
      end
      blk.call
    end
    
  end
   
end

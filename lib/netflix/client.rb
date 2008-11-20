require "oauth"

module Netflix
  
  OAUTH_ENDPOINTS = {
    :request => "http://api.netflix.com/oauth/request_token",
    :authorize => "https://api-user.netflix.com/oauth/login",
    :access => "http://api.netflix.com/oauth/access_token"
  }
    
  # for bloed ups.  
  class NetflixClientError < StandardError; end  
    
  # Client class responsible for setting up api calls.
  class Client
    attr_accessor :consumer_key, :consumer_secret, :application_name, :api_version
    
    def initialize(consumer_key, consumer_secret, application_name)
      raise ArgumentError if consumer_key.nil? or consumer_secret.nil? or application_name.nil?
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
      @application_name = application_name
      @api_version = "1.0"
      
      @access_token = nil
      @access_token_secret = nil
    end    
    
    # client.generate_request_token("http://cnn.com/") do |t, s, auth_url|
    #   # save to db here.
    #   redirect_to auth_url
    # end
    def generate_request_token(callback_url, &blk)
      raise ArgumentError.new("a block is required as the last arguement") unless block_given?
      # assert that we can do this here...
      
      # populate oauth token
      # return token, secret
      # do stuff
      
      # give this to the client so that they can save it and stuff
      yield request_token, request_token_secret, build_authorize_url(callback_url)
    end
   
    # assuming we have stored these somewhere
    # this just gets us the tokens, we need to have an object that will allow us to make calls.
    # client.generate_access_token(rt, rs) do |t, s, uid|
    #   # save to db here.
    #   
    #   # do class_eval so that we can just call go(:get, "/queue")
    # end
    def generate_access_token(request_token, request_token_secret, &blk)
      raise ArgumentError.new("a block is required as the last arguement") unless block_given?
      
      yield access_token, access_token_secret, user_id
      # use the request token here to get an access token
      # return access token and user id to save.
      # return token, secret
    end
    
    
    # client.from_access_token(at, as) do |s|
    # do class_eval so that we can just call go(:get, "/queue")
    # end
    def from_access_token(access_token, access_token_secret, &blk)
      raise ArgumentError.new("a block is required as the last arguement") unless block_given?      
      #pass infos to the client
      # set instance vars that the oauth client uses.
      # evaluate this block
      yield
    end
    
    def go(method, path, expansions = [], arguments = {})
      raise NetflixClientError.new("An access token is required to make api calls") if @access_token.nil? or @access_token_secret.nil?
      
      # fail if no access creds.
      # populate access token with instance vars.
      # delegate to the client class
    end
    
    protected
     
    def build_authorize_url(callback_url)
      raise
    end  
       
  end
  
end
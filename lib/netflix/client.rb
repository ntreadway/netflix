require "oauth"

module Netflix
  
  OAUTH_ENDPOINTS = {
    :request => "http://api.netflix.com/oauth/request_token",
    :authorize => "https://api-user.netflix.com/oauth/login",
    :access => "http://api.netflix.com/oauth/access_token"
  }.freeze
    
  # for bloed ups.  
  class ClientError < StandardError; end  
    
  # Client class responsible for setting up api calls.
  class AssHat
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
    
    # client.acquire_request_token("http://cnn.com/") do |t, s, auth_url|
    #   # save to db here.
    #   redirect_to auth_url
    # end
    def acquire_request_token(callback_url, &blk)
      
      # populate oauth token
      # return token, secret
      # do stuff
      
      # give this to the client so that they can save it and stuff
      blk.call request_token, request_token_secret, build_authorize_url(callback_url)
    end
   
    # assuming we have stored these somewhere
    # this just gets us the tokens, we need to have an object that will allow us to make calls.
    # client.exchange_request_token_for_access_token(rt, rs) do |t, s, uid|
    #   # save to db here.
    #   
    #   # do class_eval so that we can just call go(:get, "/queue")
    # end
    def exchange_request_token_for_access_token(request_token, request_token_secret, &blk)      
       blk.call access_token, access_token_secret, user_id
      # use the request token here to get an access token
      # return access token and user id to save.
      # return token, secret
    end
    
    
    # client.from_access_token(at, as) do |s|
    # do class_eval so that we can just call go(:get, "/queue")
    # end
    def from_access_token(access_token, access_token_secret, &blk)
      #pass infos to the client
      # set instance vars that the oauth client uses.
      # evaluate this block
      blk.call AccessTokenWrapper.new(access_token, access_token_secret, user_id)
    end
    
    def build_authorize_url(callback_url)
      raise
    end 
       
  end
  
  class Client  
    
    def self.consumer_token=(consumer_token)
      @consumer_token = consumer_token
    end
    
    def self.consumer_token
      @consumer_token
    end
    
    def self.consumer_secret=(consumer_secret)
      @consumer_secret = consumer_secret
    end
    
    def self.consumer_secret
      @consumer_secret
    end
    
    def self.options
    {
        :scheme            => :query_string,
        :http_method       => :post,
        :signature_method  => "HMAC-SHA1",
        :site              => "http://api.netflix.com",
        :request_token_url => Netflix::OAUTH_ENDPOINTS[:request],
        :access_token_url  => Netflix::OAUTH_ENDPOINTS[:access],
        :authorize_url     => Netflix::OAUTH_ENDPOINTS[:authorize]
    }
    end

    def consumer
      @consumer ||= begin
        token  = Netflix::Client.consumer_token
        secret = Netflix::Client.consumer_secret

        raise(ClientError, 'Consumer token and secret are required') if (token.nil? || secret.nil?)
        OAuth::Consumer.new(token, secret, self.class.options)
      end
    end
    
    def request_token
      @request_token ||= self.consumer.get_request_token
    end
    
    def access_token
      @access_token ||= self.request_token.get_access_token
    end
    
    def get
      self.access_token
    end
    
    
    # attr_accessor :access_token, :access_token_secret, :user_id
    # 
    # def initialize(access_token, access_token_secret, user_id)
    #   @access_token = access_token
    #   @access_token_secret = access_token_secret
    #   @user_id = user_id
    # end
    # 
    # def user
    #   
    # end
    # 
    # def get(path, arguments = {})
    #   raise Netflix::NetflixClientError.new("An access token is required to make api calls") if @access_token.nil? or @access_token_secret.nil?
    # 
    #     
    # 
    #   # fail if no access creds.
    #   # populate access token with instance vars.
    #   # delegate to the client class
    #   # need to append "Accept-Encoding" => "compress" as header and figure out a way to append the etag stuff.
    #   # supposedly /users/current will work but i have yet to see this working.
    #   
    # end
  
  end

end

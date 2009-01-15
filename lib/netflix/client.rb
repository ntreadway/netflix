require "oauth"

module Netflix
  
  NETFLIX_ENDPOINTS = {
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
    def initiate(callback_url, &blk)
      # populate oauth token
      # return token, secret
      # do stuff
      
      # give this to the client so that they can save it and stuff
      blk.call request_token, request_token_secret, callback_url
    end
   
    # assuming we have stored these somewhere
    # this just gets us the tokens, we need to have an object that will allow us to make calls.
    # client.exchange_request_token_for_access_token(rt, rs) do |t, s, uid|
    #   # save to db here.
    #   
    #   # do class_eval so that we can just call go(:get, "/queue")
    # end
    def authorize_account(request_token, request_token_secret, &blk)
      # make the access token call. make the secondary call to
      # /user/current to retreive the user_id
      # return the block with the access_token, access_token_secret
      # and user_id so that the client can save everything
      blk.call access_token, access_token_secret, user_id
      
    end
   
    # client.from_access_token(at, as) do |s|
    # do class_eval so that we can just call go(:get, "/queue")
    # end
    def issue(access_token, access_token_secret, &blk)
      #pass infos to the client
      # set instance vars that the oauth client uses.
      # evaluate this block
      blk.call Request.new(access_token, access_token_secret, user_id)
    end
    
    private
    
    # make simple api calls.
    class Request
      def get; end
      def post; end
      def delete; end
    end
    
    # just wrap the hpricot response for now.
    class Response
      attr_reader :content
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
        :request_token_url => Netflix::NETFLIX_ENDPOINTS[:request],
        :access_token_url  => Netflix::NETFLIX_ENDPOINTS[:access],
        :authorize_url     => Netflix::NETFLIX_ENDPOINTS[:authorize]
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
    
  end

end

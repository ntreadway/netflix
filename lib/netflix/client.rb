module Netflix
    
  # wrap exceptions as our own.
  class ClientError < StandardError; end  
    
  # Client class responsible for setting up api calls.
  class Client

    def initialize(access_token = nil, access_token_secret = nil, &blk)
      @access_token = access_token
      @access_token_secret = access_token_secret
      @user_id = nil
      @api_version = "1.0"
      blk.call(self) if block_given?
    end    
      
    # client.initiate_authorization("http://cnn.com/") do |t, s, auth_url|
    #  # save to db here.
    #  redirect_to auth_url
    # end
    def initiate_authorization(callback_url, &blk)
      consumer = build_consumer
      request_token = consumer.get_request_token
      blk.call request_token.token, request_token.secret, prepare_authorize_url(callback_url)
    end
   
    # assuming we have stored these somewhere
    # this just gets us the tokens, we need to have an object that will allow us to make calls.
    # client.verify_account(rt, rs) do |config, token, secret, user_id|
    #   config.get "/queue"
    # end
    def verify_account(request_token, request_token_secret, &blk)
      # make the access token call. make the secondary call to
      # /user/current to retreive the user_id
      # return the block with the access_token, access_token_secret
      # and user_id so that the client can save everything
      @access_token = OAuth::AccessToken.new(build_consumer,
        request_token,
        request_token_secret)
      current_user = get "/users/current"
      user_id = current_user.search(:user/id)
      # need to make api call to /users/current to get user_id
      blk.call(self, @access_token.token, @access_token.secret, user_id)
    end
   
    def get(url, *args)
      access_token_guard! do
        @access_token.get url, args
      end  
    end

    def post(url, *args)
      access_token_guard! do
        @access_token.post url, args      
      end
    end

    def delete(url, *args)
      access_token_guard! do
        @access_token.delete url, args
      end
    end
    
    private

    def prepare_authorize_url(callback_url)
      callback_url
    end
    
    def build_consumer
      consumer_token = Netflix::Configuration.consumer_token
      consumer_secret = Netflix::Configuration.consumer_secret
      options = Netflix::Configuration.api_options
      OAuth::Consumer.new(consumer_token, consumer_secret, options)
    end
    
    # assert that the client has an access token before making api
    #calls.
    def access_token_guard!(&blk)
      raise ClientError.new("access_token is required.") if @access_token.nil?
      raise ClientError.new("access_token_secret is required.") if @access_token_secret.nil?
      blk.call
    end

  end
   
end

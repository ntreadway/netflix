module Netflix
  
  # TODO: for now this encapsulates the http schemantics
  # for making api calls.
  # later this can be replaced with calls like user or catalog that
  # will enable the user the traverse the various objects
  class AccessTokenMissingError < StandardError; end
  
  class ApiRequest
    DEFAULT_REQUEST_PARAMS = {"Accept-Encoding" => "compress"}.freeze
        
    def initialize(access_token_instance)
      @access_token = access_token_instance                                 
    end

    # do a get to the /users/current endpoint and parse the user_id
    def user_id
      get("/users/current")
    end
    
    def get(uri, *args)
      access_token_guard! do
       self.access_token.get uri, build_params(*args)
      end
    end

    def post(uri, *args)
      access_token_guard! do
        self.access_token.post uri, build_params(*args)
      end
    end

    def delete(uri, *args)
      access_token_guard! do
        self.access_token.delete uri, build_params(*args)
      end
    end
    
    protected
    
    attr_accessor :access_token
    
    def build_params(*params)
      DEFAULT_REQUEST_PARAMS.dup.merge(Hash[*params]).flatten
    end
    
    # assert that the client has an access_token before api calls.
    def access_token_guard!(&blk)
      raise AccessTokenMissingError.new if self.access_token.nil?
      blk.call
    end
   
  end
 
end

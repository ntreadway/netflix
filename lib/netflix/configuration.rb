module Netflix
  
  # Config structure that represents the information that is needed
  # For a client to connect to netflix via OAuth
  class Configuration
      
    class << self

      @@api_version = "1.0".freeze
      
      @@application_name = nil

      @@consumer_token = nil

      @@consumer_secret = nil
     
      @@api_options = {
        :request_token_url => "http://api.netflix.com/oauth/request_token",
        :access_token_url  => "https://api-user.netflix.com/oauth/login",
        :authorize_url     => "http://api.netflix.com/oauth/access_token",
        :scheme            => :query_string,
        :http_method       => :post,
        :signature_method  => "HMAC-SHA1",
        :site              => "http://api.netflix.com"
      }.freeze
      
      def application_name=(application_name)
        @@application_name = application_name 
      end
    
      def application_name
        @@application_name
      end
  
      def consumer_token=(consumer_token)
        @@consumer_token = consumer_token
      end
    
      def consumer_token
        @@consumer_token
      end
    
      def consumer_secret=(consumer_secret)
        @@consumer_secret = consumer_secret
      end
    
      def consumer_secret
        @@consumer_secret
      end

      def api_version
        @@api_version
      end
      
      def build_consumer
        OAuth::Consumer.new(@@consumer_token, @@consumer_secret, @@api_options)
      end
      
    end
      
  end
      
end

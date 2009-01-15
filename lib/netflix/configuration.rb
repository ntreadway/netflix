module Netflix
  

  # Config structure that represents the information that is needed
  # For a client to connect to netflix via OAuth
  class Configuration
      
    class << self
      
      # if a block is passed here, return the class so we can set the
      # values. Really just a nice way to represent the setting in block.
      def run
        yield self if block_given?
      end
 
      def application_name=(application_name)
        @@application_name = application_name 
      end
    
      def application_name
        @@application_name ||= ""
      end
  
      def consumer_token=(consumer_token)
        @@consumer_token = consumer_token
      end
    
      def consumer_token
        @@consumer_token ||= ""
      end
    
      def consumer_secret=(consumer_secret)
        @@consumer_secret = consumer_secret
      end
    
      def consumer_secret
        @@consumer_secret ||= ""
      end
      
    end
      
  end
      
end

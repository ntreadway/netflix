module Netflix
  
  class Configuration
    
    # if a block is passed here, return the class so we can set the values.
    def initialize
      yield self.class if block_given?
    end
 
    class << self
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

require "configuration"

module Netflix
  
  class Initializer
    
    # pass the config here. good place to default and validate.
    def self.run(&blk)
      Configuration.application_name = ""
      Configuration.consumer_token = ""
      Configuration.consumer_secret = ""
      
      blk.call Configuration
      
      # validate here.
    end
    
  end
  
end

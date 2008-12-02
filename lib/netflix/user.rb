module Netflix
  class User
    
    def initialize(wrapper)
      @wrapper = wrapper
    end
    
    def populate(response)
      @document = response
    end

    def current
      self.populate(@wrapper.get("/user/#{@wrapper.user_id}"))
    end
    
    def id
      @document.at("//user_id").inner_text      
    end
    
    def first_name
      @document.at('//first_name').inner_text
    end
    
    def last_name
      @document.at("//last_name").inner_text
    end
    
  end
end
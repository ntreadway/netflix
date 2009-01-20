module Netflix
  
  class Response
    attr_reader :content

    def initialize(netflix_response)
      @content = Hpricot.XML(netflix_response.body)
    end
    
  end
  
end

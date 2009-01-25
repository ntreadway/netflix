

module OAuth
  
  class RequestToken < ConsumerToken

    def authorize_url(*additional_params)
      additional_params = Hash[*additional_params]
      additional_params.merge!({:oauth_token => token})
      build_authorize_url(consumer.authorize_url, additional_params)   
    end

    protected
      
      # helper that allows us to make the authorize url for the client to redirect to.
      def build_authorize_url(root_url, params)
        "%s?%s" % [root_url, params.map { |k,v| "#{k}=#{CGI.escape(v)}"}.join("&")]
      end
   
  end
 
end

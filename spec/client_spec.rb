require File.dirname(__FILE__) + '/spec_helper'

module Netflix
  
  describe Client, "the class" do
      
    it "should have a class-level accessor for the consumer token" do
      Client.consumer_token = 'my_token'
      Client.consumer_token.should == 'my_token'
    end
    
    it "should have a class-level accessor for the consumer secret" do
      Client.consumer_secret = 'secret'
      Client.consumer_secret.should == 'secret'
    end
    
  end
  
  describe Client, "an instance" do
  
    before do
      Client.consumer_token  = nil
      Client.consumer_secret = nil
    end

    it "should throw an exception when creating a consumer without a supplied token & secret" do
      client = Client.new
      lambda { client.consumer }.should raise_error(Netflix::ClientError)
    end
    
    it "should have a set of options to pass to the OAuth Consumer" do
      expected = {
        :scheme            => :query_string,
        :http_method       => :post,
        :signature_method  => "HMAC-SHA1",
        :site              => "http://api.netflix.com",
        :request_token_url => "http://api.netflix.com/oauth/request_token",
        :access_token_url  => "http://api.netflix.com/oauth/access_token",
        :authorize_url     => "https://api-user.netflix.com/oauth/login"
      }
      
      Netflix::Client.options.should == expected
    end
    
    it "should throw an exception when creating an access_token without a supplied access_token and access_secret"
    
    describe "with a consumer token and consumer secret" do
      
      before do
        @token = 'toke'
        @secret = 'secret'
        
        Client.consumer_token  = @token
        Client.consumer_secret = @secret
        
        @client = Client.new
      end

      it "should create a consumer from the token and supplied secret" do
        consumer = stub()
        options  = stub()
        
        Client.expects(:options).with().returns(options)
        
        OAuth::Consumer.expects(:new).with(@token, @secret, options).returns(consumer)

        @client.consumer.should == consumer
      end

      it "should memoize the consumer object" do
        OAuth::Consumer.expects(:new).with(@token, @secret, kind_of(Hash)).once.returns(stub())

        2.times { @client.consumer }
      end
      
      it "should be able to generate a request token" do
        request_token = stub()
        
        @client.expects(:consumer).with().returns(stub(:get_request_token => request_token))
        @client.request_token.should == request_token
      end
      
      it "should memoize the request token" do
        request_token = stub()
        
        consumer_mock = mock() {|m| m.expects(:get_request_token).with().once.returns(request_token) }
        @client.expects(:consumer).with().returns(consumer_mock)
        
        2.times { @client.request_token }
      end

      it "should be able to create an access token" do
        access_token = stub()
        
        @client.expects(:request_token).with().returns(stub(:get_access_token => access_token))
        @client.access_token.should == access_token
      end
      
      it "should memoize the access token" do
        access_token = stub()
        
        @client.expects(:request_token).with().returns(stub(:get_access_token => access_token))
        2.times { @client.access_token }
      end

      it "should create an access_token before issuing get request" do
        @client.expects(:access_token).with().returns(stub())
        @client.get
      end
      
    end
  
    it "should return a hpricot document on a get request" 
    it "should know if there were API errors when performing a get request"
    
  end
end
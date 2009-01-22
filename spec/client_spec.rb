require File.dirname(__FILE__) + '/spec_helper'

describe "Client an instance" do

  before(:each) do
    Netflix::Initializer.run do |c|
      c.consumer_token = "4u7tzsbkknm4gp3nccad4wtp"
      c.consumer_secret = "Ux9sHvQNeP"
      c.application_name = "Qflip"
    end
  end
    
  context "when being created without an access token" do
      
    it "should raise an error if no access token is passed and the api is accessed" do
      Netflix::Client.new do |c|
        lambda { c.get "/queue" }.should raise_error(Netflix::ClientError)
      end
    end
      
    it "should allow the client to initiate the authorization process" do
      # need to mock the consumer test here.
      Netflix::Client.new do |c|
        lambda { c.initiate_authorization("cnn.com") {} }.should_not raise_error
      end
    end
  end
    
  context "when being created with an access token" do

    it "should create the object and yield a block if passed" do
        
    end
      
    it "should not raise errors at all while being created" do
    end
     
  end
    
end


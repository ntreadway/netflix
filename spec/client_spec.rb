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
  
    it "should create a consumer from the token and supplied secret"
    it "should throw an exception when creating a consumer without a supplied token & secret"
    it "should create an access_token before issuing get request"
    it "should throw an exception when creating an access_token without a supplied access_token and access_secret"
    it "should return a hpricot document on a get request" 
    it "should know if there were API errors when performing a get request"
    
  end
end
require File.dirname(__FILE__) + '/spec_helper'
require "configuration"

module Netflix

  describe Configuration, "the class" do
    
    before do
      Netflix::Configuration.application_name = "failweb"
      Netflix::Configuration.consumer_token = "token"
      Netflix::Configuration.consumer_secret = "secret"  
    end
    
    it "should allow the client to get the :application name" do
      Netflix::Configuration.application_name.should == "failweb"
    end
    
    it "should allow the client to get the :consumer_token" do
      Netflix::Configuration.consumer_token.should == "token"
    end
    
    it "should allow the client to get the :consumer_secret" do
      Netflix::Configuration.consumer_secret.should == "secret"
    end
    
    it "should return the api version that it is using" do
      Netflix::Configuration.api_version.should == "1.0"
    end

    it "should return a new OAuth::Consumer object everytime #build_consumer is called" do
      Netflix::Configuration.build_consumer.should_not === Netflix::Configuration.build_consumer
    end
    
  end

end

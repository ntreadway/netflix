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

    it "should yield the class from the initializer; maintaining scope" do
      Netflix::Configuration.application_name.should == "failweb"
      Netflix::Configuration.run do |c|
        c.application_name = "app"
        c.application_name.should == "app"
      end
      Netflix::Configuration.application_name.should == "app"
    end
   
  end

end

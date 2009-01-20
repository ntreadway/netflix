require File.dirname(__FILE__) + "/spec_helper"
require "initializer"
require "configuration"

module Netflix

  describe Initializer, "the class" do
    
    it "should yield the configuration class" do
      Netflix::Initializer.run do |config|
        config.class.should == Netflix::Configuration.class
      end
    end

    it "should allow the configuration to be mutated by the block" do
      Netflix::Configuration.application_name = "test"
      Netflix::Initializer.run do |config|
        Netflix::Configuration.application_name = "foo"
      end
      Netflix::Configuration.application_name.should == "foo"
    end
   
  end
  
end

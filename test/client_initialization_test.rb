require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class ClientInitializationTest < Test::Unit::TestCase

  context "The Client class" do
  
    context "while being created" do
       
      it "should be creatable with an empty initializer" do
        lambda { Netflix::Client.new }.should_not raise_error  
      end
    
      it "should yield Netflix::Configuration when invoking the initializer" do
        Netflix::Client.configure do |c|
          c.class.should be Netflix::Configuration.class
        end
      end
    
      it "should return the Client class after yielding to the block" do
        lambda { Netflix::Client.configure {} }.should     
      end
  
      it "should allow the calling code to change the global config values via the intializer block" do
        Netflix::Configuration.application_name = "kinda_win"
        Netflix::Configuration.application_name.should == "kinda_win"
        Netflix::Client.configure do |c|
          c.application_name = "kinda_fail"
        end
        Netflix::Configuration.application_name.should == "kinda_fail"
      end
    
    end
      
    it "should respond to :begin_verification" do
      Netflix::Client.new.should respond_to(:begin_verification)
    end

    it "should respond to :finalize_verification" do
      Netflix::Client.new.should respond_to(:finalize_verification)
    end

    it "should respond to :api" do
      Netflix::Client.new.should respond_to(:api)
    end

    context "while being created without a persisted access token" do
    
      it "should raise an error if no access token is passed and the api is accessed" do
        lambda { Netflix::Client.new.api(nil, nil).get "/queue" }.should raise_error(Netflix::ClientError)
      end
    
      # FIXME: mock oauth objects
      it "should allow the client to initiate the authorization process" do
        # need to mock the consumer test here.
        # really should be .should_not raise...
        lambda { Netflix::Client.new.begin_verification("http://netflix.com") {} }.should raise_error
      end
    
      it "should yield a request token and request token secret along with a callback url" do
        lambda {}.should 
      end
    
    end
    
    context "while being created with an access token that the client supplied" do
    
      # FIXME: mock oauth objects
      it "should create the object and yield a block if passed" do
        lambda { Netflix::Client.new.api(nil, nil).get("/users/current") }.should raise_error
      end
    
    end

  end
  
end
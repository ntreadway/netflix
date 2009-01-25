require File.dirname(__FILE__) + "/spec_helper"

describe Netflix::Client do

  before(:each) do
    @netflix = Netflix::Client.new
  end
 
  it "should allow for object creation via an empty constructor" do
    lambda { Netflix::Client.new }.should_not raise_error
  end

  it "should return an instance of Client from the #configure class method after yielding the Configration class to the block" do
    Netflix::Client.configure do |c|
      c.should be_a_instance_of(Netflix::Configuration.class)
    end.should be_a_instance_of(Netflix::Client)
  end
  
  it "should allow the calling code to change the global config values via the intializer block" do
    Netflix::Configuration.application_name = "kinda_win"
    Netflix::Configuration.application_name.should == "kinda_win"
    Netflix::Client.configure do |c|
      c.application_name = "kinda_fail"
    end
    Netflix::Configuration.application_name.should == "kinda_fail"
  end
 
  it "should respond to :begin_verification" do
    @netflix.should respond_to(:begin_verification)
  end
  
  it "should respond to :finalize_verification" do
    @netflix.should respond_to(:finalize_verification)
  end
  
  it "should respond to :api" do
    @netflix.should respond_to(:api)
  end
  
  it "should respond to :get" do
    @netflix.should respond_to(:get)
  end

  it "should respond to :post" do
    @netflix.should respond_to(:post)
  end

  it "should respond to :delete" do
    @netflix.should respond_to(:delete)
  end
  
  context "when being created without a persisted access token (oauth handshake)" do
    
    before(:each) do
      # mock here.
    end

    it "should raise an error if no access token is passed and the api is accessed" do
      lambda { @netflix.get "/queue" }.should raise_error(Netflix::ClientError)
    end
    
    # FIXME: mock oauth objects
    it "should allow the client to initiate the authorization process" do
      # need to mock the consumer test here.
      # really should be .should_not raise...
      lambda { @netflix.begin_verification("http://netflix.com") {} }.should raise_error
    end
    
    it "should yield a request token and request token secret along with a callback url" do
      lambda {}.should 
    end
    
  end
    
  context "when being created with an access token that the client supplied" do
    
    before(:each) do
      @netflix = Netflix::Client.new
    end

    # FIXME: mock oauth objects
    it "should create the object and yield a block if passed" do
      lambda{ @netflix.api("", "").get("/users/current")}.should raise_error
    end
      
  end
    
end


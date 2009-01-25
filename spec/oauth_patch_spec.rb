require File.dirname(__FILE__) + "/spec_helper"
require "rubygems"
require "oauth"
require "oauth/patches/token"

describe OAuth::RequestToken, "an instance" do
  
  before(:all) do
    @consumer = mock
    @consumer.stubs(:authorize_url).returns("http://example.com/")
    @request_token = OAuth::RequestToken.new(@consumer, "token", "secret")
  end
 
  it "should allow the client to pass splat args to #authorize_url without exception" do    
    lambda {@request_token.authorize_url(:application_name => "kinda_win")}.should_not raise_error
  end

  it "should build an auth url with the key value pairs passed to it and return it" do
   @request_token.authorize_url(:application_name => "c").should == "http://example.com/?application_name=c&oauth_token=token"
  end

  it "should raise exceptions if the splat args pased in can't be coerced to a Hash" do
    lambda { @request_token.authorize_url(1, [3, 90], "ds") }.should raise_error
  end
 
end

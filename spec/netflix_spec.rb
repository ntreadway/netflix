require File.dirname(__FILE__) + "/spec_helper"
# require "client"
# 
# module Netflix
# 
#   describe Client, "When initially created" do
#   
#     before do               
#     
#     end
#   
#     before(:each) do
#     end
#   
#     it "should define netflix OAuth endpoints" do
#       OAUTH_ENDPOINTS.class.should == Hash 
#       OAUTH_ENDPOINTS.size.should == 3    
#     end
#   
#     it "should be createable" do
#       lambda {AssHat.new("", "", "")}.should_not == nil
#     end
#   
#     it "should throw an ArgumentError if nil initializer args are passed" do
#       lambda {AssHat.new(nil, nil, nil)}.should raise_error(ArgumentError)
#     end
#   
#     it "should respond to various accessors" do
#       client = AssHat.new("", "", "")
#       client.should respond_to(:consumer_key)
#       client.should respond_to(:consumer_secret) 
#       client.should respond_to(:application_name)
#       client.should respond_to(:api_version)           
#     end
#   
#     it "should default the api version" do
#       client = AssHat.new("", "", "")
#       client.api_version.should == "1.0"  
#     end
#   
#     it "should respond to a #acquire_request_token instance method and yield 3 variables" do
#       client = AssHat.new("", "", "")
#       client.should respond_to(:acquire_request_token)
#     end
#     it "should respond to a #exchange_request_token_for_access_token instance method and yield 3 variables" do
#       client = AssHat.new("", "", "")
#       client.should respond_to(:exchange_request_token_for_access_token)  
#     end
#   
#     it "should respond to a #from_access_token and yield nothing" do
#       client = AssHat.new("", "", "")
#       client.should respond_to(:from_access_token)
#     end
#   
#     it "should raise NetflixClientError if no access token info is available when creating a new AccessTokenWrapper" do
#       lambda {Client.new(nil, nil).go(:get, "/")}.should raise_error(NetflixClientError)
#     end
#   end
# 
# end
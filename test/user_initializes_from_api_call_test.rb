require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class UserInitializesFromApiCallTest < Test::Unit::TestCase

  context "A User instance" do
  
    it "should be able to find the current user" do
      document = Hpricot.XML(File.read(File.dirname(__FILE__) + '/fixtures/user.xml'))      
      wrapper = mock() do |m|
        m.expects(:user_id).with().returns('1')
        m.expects(:get).with('/user/1').returns(document)
      end
      user = Netflix::User.new(wrapper)
      user.expects(:populate).with(document)
      user.current
    end

    context "when loading data from an XML response" do

      before do
        document = Hpricot.XML(File.read(File.dirname(__FILE__) + '/fixtures/user.xml'))
        @user = Netflix::User.new(stub())
        @user.populate(document)
      end

      it "should have a value for :id" do
        @user.id.should == 'T1PambOVJXcoWzNRQEyacp76BnRn0TIJdxKGyklbY0srg-'
      end
      
      it "should have a value for :first_name" do
        @user.first_name.should == "Jane"
      end
        
      it "should have a value for :last_name" do
        @user.last_name.should == "Smith"
      end
      
    end
 
  end
 
end
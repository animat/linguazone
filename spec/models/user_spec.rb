require 'spec_helper'

describe User do
  it "sets the display name before create" do
    user = User.new :first_name => "John", :last_name => "Smith", :password => "boo123!", :email => "john@smith.com"
    user.save
    user.display_name.should == "John Smith"
  end
end

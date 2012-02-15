require "spec_helper"

describe "Config" do
  
  it "should set user" do
    AprovaFacilStack::Config.user.should be_null
  end
  
end
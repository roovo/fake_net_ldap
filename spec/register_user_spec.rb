require 'spec_helper'

describe "registering users" do

  it "should return true when binding for a registered user" do
    FakeNetLdap.register_user(:username => "fred", :password => "secret")
    connection = ldap_connection
    connection.auth("fred", "secret")
    connection.bind.should be_true
  end
end


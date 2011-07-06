require 'spec_helper'

describe "registering users" do

  before do
    FakeNetLdap.clear_user_registrations
  end

  it "should return true when binding for a registered user" do
    FakeNetLdap.register_user(:username => "fred", :password => "secret")
    connection = ldap_connection
    connection.auth("fred", "secret")
    connection.bind.should be_true
  end

  it "should return false when binding for an unregistered user" do
    connection = ldap_connection
    connection.auth("fred", "secret")
    connection.bind.should be_false
  end

  it "should return false when binding for a registered user with the wrong password" do
    FakeNetLdap.register_user(:username => "fred", :password => "secret")
    connection = ldap_connection
    connection.auth("fred", "wrong_password")
    connection.bind.should be_false
  end
end


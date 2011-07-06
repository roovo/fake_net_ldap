require 'spec_helper'

describe "clearing user registrations" do

  it "it should not show a user as registered after user registrations have been cleared" do
    FakeNetLdap.register_user(:username => "fred", :password => "secret")
    FakeNetLdap.clear_user_registrations
    FakeNetLdap.user_registered?(:username => "fred", :password => "secret").should be_false
  end

  it "it should not allow binds once user registrations have been cleared" do
    FakeNetLdap.register_user(:username => "fred", :password => "secret")
    FakeNetLdap.clear_user_registrations
    connection = ldap_connection
    connection.auth("fred", "secret")
    connection.bind.should be_false
  end
end

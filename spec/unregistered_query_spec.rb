require 'spec_helper'

describe "registering a response to unregistered queries" do

  let(:filter) { Net::LDAP::Filter.present("objectclass") }
  let(:connection) { ldap_connection }

  before do
    FakeNetLdap.clear_query_registrations
  end

  it "should raise an ConnectionNotAllowed exception if the response to unregistered queries has not been set" do
    FakeNetLdap.query_registered?(filter).should be_false
    lambda { connection.search(:base => 'cn=plop', :filter => filter) { |r| } }.should raise_error(FakeNetLdap::ConnectionNotAllowed)
  end

  it "should say that a query is registered if it hasn't been but the response to unregistered queries has been set" do
    FakeNetLdap.register_query(:unregistered_query, {"name" => "Fred Blogs"})
    FakeNetLdap.query_registered?(filter).should be_true
  end

  it "should return the response if the response to unregistered queries has been set" do
    FakeNetLdap.register_query(:unregistered_query, {"name" => "Fred Blogs"})
    responses = []
    connection.stub(:bind).and_return(true)
    connection.search(:base => 'cn=plop', :filter => filter) do |result|
      responses << result
    end
    responses.should == [{"name" => "Fred Blogs"}]
  end
end


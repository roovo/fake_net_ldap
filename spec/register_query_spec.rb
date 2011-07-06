require 'spec_helper'

describe "registering queries" do

  let(:filter) { Net::LDAP::Filter.present("objectclass") }

  it "should allow queries to be registered to respond with a hash (for a single response)" do
    FakeNetLdap.register_query(filter, {"name" => "Fred Blogs"})
    FakeNetLdap.query_registered?(filter).should be_true
  end

  it "should allow queries to be registered to respond with an array (for multiple responses)" do
    FakeNetLdap.register_query(filter, [{"name" => "Fred Blogs"}, {"name" => "John Smith"}])
    FakeNetLdap.query_registered?(filter).should be_true
  end

  it "should allow queries to be registered which should raise an exception" do
    FakeNetLdap.register_query(filter, StandardError)
    FakeNetLdap.query_registered?(filter).should be_true
  end

  it "shold show an unregistered query as unregistered" do
    FakeNetLdap.query_registered?(filter).should be_false
  end

  it "should yield the registered response if a hash response is registered" do
    FakeNetLdap.register_query(filter,  {"name" => "Fred Blogs"})
    responses = []
    connection = ldap_connection
    connection.search(:base => 'cn=plop', :filter => filter) do |result|
      responses << result
    end
    responses.should == [{"name" => "Fred Blogs"}]
  end
end

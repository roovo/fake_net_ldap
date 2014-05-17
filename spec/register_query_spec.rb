require 'spec_helper'

describe "registering queries" do

  let(:filter) { Net::LDAP::Filter.present("objectclass") }

  before do
    FakeNetLdap.clear_query_registrations
  end

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

  it "should yield the registered response if an array response is registered" do
    FakeNetLdap.register_query(filter,  [{"name" => "Fred Blogs"}, {"name" => "John Smith"}])
    filter_copy = Net::LDAP::Filter.present("objectclass")
    responses = []
    connection = ldap_connection
    connection.search(:base => 'cn=plop', :filter => filter_copy) do |result|
      responses << result
    end
    responses.should == [{"name" => "Fred Blogs"}, {"name" => "John Smith"}]
  end

  it "should return the registered response if a hash response is registered and block is not passed" do
    FakeNetLdap.register_query(filter,  {"name" => "Fred Blogs"})
    responses = ldap_connection.search(base: 'cn=plop', filter: filter)
    responses.should == {"name" => "Fred Blogs"}
  end

  it "should return the registered response if an array response is registered and block is not passed" do
    FakeNetLdap.register_query(filter,  [{"name" => "Fred Blogs"}, {"name" => "John Smith"}])
    responses = ldap_connection.search(base: 'cn=plop', filter: filter)
    responses.should == [{"name" => "Fred Blogs"}, {"name" => "John Smith"}]
  end

  it "should raise an exception if an exception response is registered" do
    class ExpectedException < StandardError ; end ;
    FakeNetLdap.register_query(filter,  ExpectedException)
    connection = ldap_connection
    lambda { connection.search(:base => 'cn=plop', :filter => filter) { |r| } }.should raise_error(ExpectedException)
  end
end

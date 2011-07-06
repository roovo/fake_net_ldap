require 'spec_helper'

describe "registering queries" do

  it "should allow queries to be registered to respond with a hash (for a single response)" do
    FakeNetLdap.register_query('with_hash_response', {"name" => "Fred Blogs"})
    FakeNetLdap.query_registered?('with_hash_response').should be_true
  end

  it "should allow queries to be registered to respond with an array (for multiple responses)" do
    FakeNetLdap.register_query('with_array_response', [{"name" => "Fred Blogs"}, {"name" => "John Smith"}])
    FakeNetLdap.query_registered?('with_array_response').should be_true
  end

  it "should allow queries to be registered which should raise an exception" do
    FakeNetLdap.register_query('with_exception_response', StandardError)
    FakeNetLdap.query_registered?('with_exception_response').should be_true
  end
end

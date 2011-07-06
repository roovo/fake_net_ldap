require 'spec_helper'

describe "registering queries" do

  it "should allow queries to be registered to respond with a hash (for a single response)" do
    FakeNetLdap.register_query('with_hash_response', {"name" => "Fred Blogs"})
    FakeNetLdap.query_registered?('with_hash_response').should be_true
  end
end

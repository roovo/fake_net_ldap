require 'spec_helper'

describe "clearing query registrations" do

  let(:filter) { Net::LDAP::Filter.present("objectclass") }

  it "it should not show a query as registered after query registrations have been cleared" do
    FakeNetLdap.register_query(filter, {"name" => "Fred Blogs"})
    FakeNetLdap.clear_query_registrations
    FakeNetLdap.query_registered?(filter).should be_false
  end

  it "it should raise an LdapConnectionNotAllowed exception after query registrations have been cleared" do
    FakeNetLdap.register_query(filter, {"name" => "Fred Blogs"})
    FakeNetLdap.clear_query_registrations
    connection = ldap_connection
    lambda { connection.search(:base => 'cn=plop', :filter => filter) { |r| } }.should raise_error(FakeNetLdap::ConnectionNotAllowed)
  end
end

require 'singleton'

require 'fake_net_ldap/ext/net_ldap'
require 'fake_net_ldap/registry'
require 'fake_net_ldap/responder'

module FakeNetLdap

  # This exception is raised if you try to make a query you haven't
  # registered.
  class ConnectionNotAllowed < StandardError ; end ;

  # call-seq:
  #   FakeNetLdap.clear_user_registrations
  #
  # clears all previously set user registrations
  #
  def self.clear_user_registrations
    Registry.instance.clear_user_registrations
  end

  # call-seq:
  #   FakeNetLdap.register_user(:username => 'some-user', :password => 'a-password')
  #
  # Register a username/password which can be used when binding to the faked Net::LDAP.
  #
  def self.register_user(attrs)
    Registry.instance.register_user(attrs)
  end

  # call-seq:
  #   FakeNetLdap.user_registered?(filter)
  #
  # Returns true if the username and password have been registered with FakeNetLdap.
  #
  def self.user_registered?(attrs)
    Registry.instance.user_registered?(attrs)
  end

  # call-seq:
  #   FakeNetLdap.clear_query_registrations
  #
  # clears all previously set query registrations
  #
  def self.clear_query_registrations
    Registry.instance.clear_query_registrations
  end

  # call-seq:
  #   FakeNetLdap.register_query(filter, response)
  #
  # Register a query filter and it's response.  The +query+ should be a
  # Net::LDAP::Filter It can also be set to the symbol :unregistered_query, in which
  # case any calls to the Net::LDAP search method with unregistered queries
  # will result in the response provided being yielded.
  #
  # Responses will be yielded to a call to the Net::LDAP search method.
  # method. The +response+ must be one of the following types:
  #
  # <tt>Hash</tt>::
  #   For cases where a single response is expected from the LDAP directory.
  #   The hash will be yielded as a result of calling the LDAP::Conn.search2 method.
  #   Example:
  #     filter = Net::LDAP::Filter.eq('uid', 'some-user')
  #     FakeNetLdap.register_query(filter, {"uid" => "some-user"})
  # <tt>Array</tt>::
  #   For cases where multiple responses are expected fron the LDAP directory.
  #   This should be an array of hashes.  Each hash in the array will be yielded
  #   in turn. Example:
  #     filter = Net::LDAP::Filter.eq('gid', 'users')
  #     FakeNetLdap.register_query(filter, [{"uid" => "Fred Blogs"}, {"uid" => "John Smith"}])
  # <tt>Exception</tt>::
  #   The specified exception will be raised when the query is made.
  #   Any +Exception+ class is valid. Example:
  #     filter = Net::LDAP::Filter.eq('gid', 'users')
  #     FakeNetLdap.register_query(filter, MyLdapError)
  #
  def self.register_query(filter, response)
    Registry.instance.register_query(filter, response)
  end

  # call-seq:
  #   FakeNetLdap.query_registered?(filter)
  #
  # Returns true if +filter+ is registered with FakeNetLdap.  This will always
  # return true if the response for :unregistered_query has been registered.
  #
  def self.query_registered?(filter)
    Registry.instance.query_registered?(filter)
  end

  # call-seq:
  #   FakeNetLdap.response_for(filter)
  #
  # Returns the faked response object associated with +filter+.
  #
  def self.response_for(filter, &block)
    Registry.instance.response_for(filter, &block)
  end
end

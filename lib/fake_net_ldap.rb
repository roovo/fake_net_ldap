require 'singleton'

require 'fake_net_ldap/ext/net_ldap'
require 'fake_net_ldap/registry'
require 'fake_net_ldap/responder'

module FakeNetLdap

  # This exception is raised if you try to make a query you haven't
  # registered.
  class ConnectionNotAllowed < StandardError ; end ;

  def self.register_user(attrs)
    Registry.instance.register_user(attrs)
  end

  def self.clear_query_registrations
    Registry.instance.clear_query_registrations
  end

  def self.register_query(query, response)
    Registry.instance.register_query(query, response)
  end

  def self.user_registered?(attrs)
    Registry.instance.user_registered?(attrs)
  end

  def self.query_registered?(query)
    Registry.instance.query_registered?(query)
  end

  def self.response_for(query, &block)
    Registry.instance.response_for(query, &block)
  end
end

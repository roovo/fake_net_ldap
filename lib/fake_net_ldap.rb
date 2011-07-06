require 'singleton'

require 'fake_net_ldap/registry'
require 'fake_net_ldap/responder'

module FakeNetLdap

  def self.register_query(query, response)
    Registry.instance.register_query(query, response)
  end

  def self.query_registered?(query)
    Registry.instance.query_registered?(query)
  end
end

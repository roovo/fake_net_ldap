require 'net/ldap'

class Net::LDAP

  def search(attrs, &block)
    if FakeNetLdap.query_registered?(attrs[:filter])
      FakeNetLdap.response_for(attrs[:filter], &block)
    else
      #raise FakeNetLdap::LdapConnectionNotAllowed,
            #"Real LDAP connections are disabled.  Unregistered query: #{filter}"
    end
  end

end

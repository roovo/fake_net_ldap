require 'net/ldap'

class Net::LDAP

  def search(attrs, &block)
    if FakeNetLdap.query_registered?(attrs[:filter])
      FakeNetLdap.response_for(attrs[:filter], &block)
    else
      raise FakeNetLdap::ConnectionNotAllowed,
            "Real LDAP connections are disabled.  Unregistered query: #{attrs[:filter]}"
    end
  end

end

require 'net/ldap'

class Net::LDAP

  def auth(username, password)
    @username = username
    @password = password
  end

  def bind
    FakeNetLdap.user_registered?(:username => @username, :password => @password)
  end

  def search(attrs, &block)
    if FakeNetLdap.query_registered?(attrs[:filter])
      bind and FakeNetLdap.response_for(attrs[:filter], &block)
    else
      raise FakeNetLdap::ConnectionNotAllowed,
            "Real LDAP connections are disabled.  Unregistered query: #{attrs[:filter]}"
    end
  end

end

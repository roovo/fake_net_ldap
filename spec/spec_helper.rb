require 'bundler'
Bundler.require
require 'net/ldap'


$:.unshift(File.expand_path('../../lib', __FILE__))
require 'fake_net_ldap'

RSpec.configure do |c|
  c.formatter = :doc
end

LDAP_HOST = "ldap.example.com"
LDAP_PORT = 389

def ldap_connection
  conn = Net::LDAP.new
  #conn.bind
end

require 'bundler'
Bundler.require

$:.unshift(File.expand_path('../../lib', __FILE__))
require 'fake_net_ldap'

RSpec.configure do |c|
  c.formatter = :doc
end


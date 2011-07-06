# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fake_net_ldap/version"

Gem::Specification.new do |s|
  s.name        = "fake_net_ldap"
  s.version     = FakeNetLdap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rupert Voelcker", "Richard Pilkington"]
  s.email       = ["rupert.voelcker@bt.com", "richard.pilkington@bt.com"]
  s.homepage    = ""
  s.summary     = %q{Use to fake out calls to Net::LDAP}

  s.add_dependency "net-ldap"

  s.add_development_dependency "rspec"

  s.rubyforge_project = "fake_net_ldap"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

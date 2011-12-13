# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_subscribable/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_subscribable"
  s.version     = ActsAsSubscribable::VERSION
  s.authors     = ["Jamie Rumbelow"]
  s.email       = ["jamie@jamierumbelow.net"]
  s.homepage    = "https://github.com/jamierumbelow/acts_as_subscribable"
  s.summary     = "Simplify adding user subscriptions to models"
  s.description = <<-desc
                    acts_as_subscribable is a loose wrapper around ActiveRecord to allow a basic user subscription model.
                    acts_as_subscribable exposes a high-level set of methods that allow you to easily subscribe, unsubscribe
                    and view subscribers to a model.
                  desc

  s.rubyforge_project = "acts_as_subscribable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

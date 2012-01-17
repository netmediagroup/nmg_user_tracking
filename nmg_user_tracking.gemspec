$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nmg_user_tracking/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "NmgUserTracking"
  s.version     = NmgUserTracking::VERSION
  s.authors     = ["Jared Howard"]
  s.email       = ["jhoward@netmediagroup.com"]
  s.homepage    = "http://github.com/netmediagroup/nmg_user_tracking"
  s.summary     = "Gather and store the user information for Net Media Group projects."
  s.description = "Gather and store the user information for Net Media Group projects."

  s.files = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.0"
end

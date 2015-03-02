$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "postally_addressable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "postally_addressable"
  s.version     = PostallyAddressable::VERSION
  s.authors     = ["mariusz360"]
  s.email       = ["mariusz.n.lapinski@gmail.com"]
  s.homepage    = ""
  s.summary     = "Add postal address to rails models"
  s.description = "Add postal address to rails models"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end

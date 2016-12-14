$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "metatron/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "metatron"
  s.version     = Metatron::VERSION
  s.authors     = ["Rob Lacey"]
  s.email       = ["contact@robl.me"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Metatron."
  s.description = "TODO: Description of Metatron."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end

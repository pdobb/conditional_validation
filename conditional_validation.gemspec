$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "conditional_validation/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "conditional_validation"
  s.version     = ConditionalValidation::VERSION
  s.authors     = ["Paul Dobbins"]
  s.email       = ["pdobbins@gmail.com"]
  s.homepage    = "https://github.com/pdobb/conditional_validation"
  s.summary     = "Add conditional validation methods to a model."
  s.description = "Validation Accessor allows controllers to communicate with models about whether or not certain validations should be run."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.0.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest-rails"
  s.add_development_dependency "minitest-ansi"
  s.add_development_dependency "wrong"
end

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "conditional_validation/version"

Gem::Specification.new do |spec|
  spec.name          = "conditional_validation"
  spec.version       = ConditionalValidation::VERSION
  spec.authors       = ["Paul Dobbins"]
  spec.email         = ["paul.dobbins@icloud.com"]

  spec.summary       = %q{ConditionalValidation simplifies adding validation flags to models.}
  spec.description   = %q{ConditionalValidation simplifies adding validation flags and then querying state to determine when associated validations should be run on models.}
  spec.homepage      = "https://github.com/pdobb/conditional_validation"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.2"
  spec.add_development_dependency "simplecov", "~> 0.16"
  spec.add_development_dependency "byebug", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_development_dependency "pry-byebug", "~> 3.6"
end

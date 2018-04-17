# Conditional Validation

[![Gem Version](https://badge.fury.io/rb/conditional_validation.svg)](https://badge.fury.io/rb/conditional_validation)
[![Build Status](https://travis-ci.org/pdobb/conditional_validation.svg?branch=master)](https://travis-ci.org/pdobb/conditional_validation)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a7cb8fa224f2390c6c99/test_coverage)](https://codeclimate.com/github/pdobb/conditional_validation/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/a7cb8fa224f2390c6c99/maintainability)](https://codeclimate.com/github/pdobb/conditional_validation/maintainability)

ConditionalValidation simplifies adding validation flags and then querying state to determine when associated validations should be run on models. While models tend to have a set of core validations that should always be run, some validations may be specific to a certain context.

The typical use-case for ConditionalValidation is to flag a model's non-core validations to run from specific controller actions, while they default to not run from all others.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "conditional_validation"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install conditional_validation


## Upgrading from v0.1.0

### Monkey Patching Eliminated

v0.1.0 automatically added ConditionalValidation::ValidationFlag to ActiveRecord::Base. Since monkey patching was never a good idea, ConditionalValidation should now be added to Models manually.

```ruby
# app/models/my_model.rb
class MyModel
  extend ConditionalValidation::ValidationFlag

  validation_flag :test_attributes
end

my_model = MyModel.new

my_model.enable_test_attributes_validation
# => #<MyModel:0x007fd76bbecb80 @_test_attributes_validation_flag=true>

my_model.validate_on_test_attributes?
# => true
```

Or, to use ConditionalValidation globally in a Rails app, call extend ConditionalValidation::ValidationFlag within ApplicationRecord.

```ruby
# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  extend ConditionalValidation::ValidationFlag
end
```


### `validation_accessor` Macro Removed

Additionally, the old ConditionalValidation::ValidationAccessor module and its `validation_accessor` macro are gone. To fix: Search and replace `validation_accessor` with `validation_flag`.


## Compatibility

Tested MRI Ruby Versions:
* 2.2.10
* 2.3.7
* 2.4.4
* 2.5.1
* edge

VersionCompare has no other dependencies.


## Usage

First, define a validation flag:

```ruby
# app/models/my_model.rb
class MyModel
  validation_flag :<flag_name>
end
```

The `validation_flag` macro will define the following instance methods on MyModel for conditional validation:

```ruby
enable_<flag_name>_validation   # Enables conditional validation
disable_<flag_name>_validation  # Disables conditional validation
validate_on_<flag_name>?        # Check if conditional validation is enabled or not
```


### A "Real World" Example

```ruby
# app/models/user.rb
class User < ApplicationRecord
  # Initialize conditional validation on address attributes
  validation_flag :address_attributes

  with_options if: :validate_on_address_attributes? do |o|
    o.validates :street, presence: true
    o.validates :city, presence: true
    # ...
  end
end

# app/controllers/user_controller.rb
class UsersController < ApplicationController
  def update
    # Enable conditional validation on address attributes
    current_user.enable_address_attributes_validation

    if current_user.save
      # Not typically needed, but disables conditional validation on address attributes
      current_user.disable_address_attributes_validation

      # ...
    end
  end
end
```


### Method Chaining

The `enable_<flag_name>_validation` and `disable_<flag_name>_validation` methods allow for method chaining so that multiple validation flags may be enabled/disabled at once:

```ruby
if current_user.
     enable_address_attributes_validation.
     enable_some_other_validation.
     save
  # ...
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pdobb/conditional_validation.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

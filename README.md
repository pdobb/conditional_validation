# Conditional Validation

[![Gem Version](https://badge.fury.io/rb/conditional_validation.png)](http://badge.fury.io/rb/conditional_validation)

Conditional Validation allows validation flags to be enabled to determine when
certain validations should be run on a model. The idea being that, while models
tend to have a set of core validations that should always be run, some
validations may be specific to a certain context or state of the object. Typical
use-case, then, is to flag a model's non-core validations to run from specific
controller actions, while they default to not run from all others.


## Compatibility

Tested with:

* Ruby: MRI 1.9.3
* Ruby: MRI 2.0.0 +
* Rails: 3+
* Rails: 4+


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'conditional_validation'
```

And then execute:

```ruby
bundle
```


## Usage

First, define a validation flag:

```ruby
# app/models/some_model.rb
class SomeModel
  validation_flag :<flag_name>
end
```

Then, the following methods will be defined on SomeModel for conditional
validation:

```ruby
enable_<flag_name>_validation # Enables conditional validation
disable_<flag_name>_validation # Disables conditional validation
validate_on_<flag_name>? # Check if conditional validation is enabled
```


### A "Real World" Example

```ruby
# app/models/user.rb
User < ActiveRecord::Base
  # Initialize conditional validation on address attributes
  validation_flag :address_attributes

  with_options if: :validate_on_address_attributes? do |obj|
    obj.validates :street, presence: true
    obj.validates :city, presence: true
    # ...
  end
end

# app/controllers/user_controller.rb
def update
  # Enable conditional validation on address attributes
  current_user.enable_address_attributes_validation
  if current_user.save
    # Not typically needed, but disables conditional validation on address attributes
    current_user.disable_address_attributes_validation
    # ...
  end
end
```

### Method Chaining

The enable and disable methods allow for method chaining so that multiple
validation flags may be enabled/disabled at once:

```ruby
if current_user.enable_address_attributes_validation.enable_some_other_validation.save
  # ...
end
```


## Author

- Paul Dobbins

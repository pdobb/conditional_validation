# Conditional Validation

[![Gem Version](https://badge.fury.io/rb/conditional_validation.png)](http://badge.fury.io/rb/conditional_validation)

Conditional Validation allows controllers to communicate with models about
whether or not certain validations should be run. This is great for multi-page
wizards and context-dependent validations.

## Compatibility

Tested with:

* Ruby: MRI 2.0.0
* Rails: 4.0.1

## Installation

Add this line to your application's Gemfile:

```ruby
gem "validation_accessor"
```

And then execute:

```ruby
bundle
```

## Usage

First, define a validation accessor:

```ruby
# app/models/some_model.rb
class SomeModel
  validation_accessor :some_grouping_name
end
```

Then, this model will receive the following methods for conditional validation:

```ruby
enable_some_grouping_name_validation # Enables conditional validation
disable_some_grouping_name_validation # Disables conditional validation
validate_on_some_grouping_name? # Check if conditional validation is enabled
```

<b>A "Real World" Example</b>

```ruby
# app/models/user.rb
User < ActiveRecord::Base
  validation_accessor :address_attributes # Initialize conditional validation on address attributes

  with_options if: :validate_on_address_attributes? do |obj|
    obj.validates :street, presence: true
    obj.validates :city, presence: true
    # ...
  end
end

# app/controllers/user_controller.rb
def update
  current_user.enable_address_attributes_validation
  if current_user.save # Enable conditional validation on address attributes
    current_user.disable_address_attributes_validation # Not necessarily needed, but disable conditional validation on address attributes
    # ...
  end
end
```

<b>Method Chaining</b>

The enable and disable methods allow for method chaining so that multiple
validation accessors may be enabled/disabled at once:

```ruby
if current_user.enable_address_attributes_validation.enable_some_other_validation.save
  # ...
end
```

## Author

- Paul Dobbins

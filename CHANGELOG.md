### 1.0.0 - 2018-04-16
- Remove the deprecated `validation_accessor` macro in favor of `validation_flag`.
- Remove ActiveRecord monkey patch. Instead, use `extend ConditionalValidation::ValidationFlag` in ApplicationRecord.
- Refresh gem. Remove Rails dependency.
- Improve README.


### 0.1.0

- Deprecate `validation_accessor` macro in favor of `validation_flag`.
- Documentation updates.

class User < ActiveRecord::Base
  attr_accessor :flag_name

  validation_flag :flag_attributes, :other_flag_attributes

  validates :name, presence: true

  with_options if: :validate_on_flag_attributes? do |user|
    user.validates :flag_name, presence: true
  end


  # DEPRECATED
  attr_accessor :accessor_name

  validation_accessor :accessor_attributes, :other_accessor_attributes

  with_options if: :validate_on_accessor_attributes? do |user|
    user.validates :accessor_name, presence: true
  end
end

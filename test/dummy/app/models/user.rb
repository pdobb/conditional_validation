class User < ActiveRecord::Base
  validation_accessor :address_attributes, :other_attributes

  validates :name, presence: true
  with_options if: :validate_on_address_attributes? do |user|
    user.validates :address, presence: true
    user.validates :city, presence: true
  end
end

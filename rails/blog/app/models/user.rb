# frozen_string_literal: true

require 'bcrypt' # Load the BCrypt library for password hashing

# The main data model and logic for Users
class User < ApplicationRecord
  include Clearance::User

  # Validations for user attributes
  validates :email, presence: true, uniqueness: true # Ensure email is present and unique
  validates :full_name, presence: false
end

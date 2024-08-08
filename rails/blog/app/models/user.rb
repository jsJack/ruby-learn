# frozen_string_literal: true

require 'bcrypt' # Load the BCrypt library for password hashing

# The main data model and logic for Users
class User < ApplicationRecord
  include BCrypt # Include the BCrypt module to use its password hashing functionality

  # Callback to encrypt the password before saving the user to the database
  before_save :encrypt_password

  # Validations for user attributes
  validates :email, presence: true, uniqueness: true # Ensure email is present and unique
  validates :full_name, presence: true # Ensure full_name is present
  validates :password, presence: true, length: { minimum: 6 }, if: :password_changed?
  # ^ Ensure password is present, at least 6 characters long, if it's being changed

  # Method to hash the password using BCrypt before saving the user
  def encrypt_password
    return unless password.present? # Check if the password is not nil or empty

    self.password = Password.create(password) # Hash the password and store it in the database
  end

  # Method to authenticate a user by comparing the given plain password with the stored hashed password
  def authenticate(plain_password)
    Password.new(password) == plain_password # Compare the hashed password with the given plain password
  end

  # Method to check if the password attribute was changed
  def password_changed?
    !password.nil? # Return true if the password is not nil
  end
end

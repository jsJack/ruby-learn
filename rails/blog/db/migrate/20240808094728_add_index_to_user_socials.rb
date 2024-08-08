# frozen_string_literal: true

# An index is like a composite key but doesn't make the primary key.
# It makes sure that the combination of the user_id and social_type is unique, therefore improving performance.
# However it does not make a primary key, so the id column is still the primary key.
class AddIndexToUserSocials < ActiveRecord::Migration[7.0]
  def change
    add_index :user_socials, %i[user_id social_type], unique: true
    # No index for url in case they have the same username on multiple platforms.
  end
end

# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_enum :account_types, %w[user contributor author admin]

    create_table :users do |t|
      t.string :full_name, null: false
      t.string :profile_picture

      t.string :email, null: false
      t.string :password, null: false

      t.enum :account_type, enum_type: :account_types, default: 'user', null: false

      # Created and Updated
      t.timestamps
    end
  end

  def down
    execute <<-SQL
      DROP TYPE account_types;
    SQL
  end
end

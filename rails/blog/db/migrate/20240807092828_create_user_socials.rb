class CreateUserSocials < ActiveRecord::Migration[7.0]
  def change
    create_enum :social_types, %w[x instagram facebook discord github website youtube twitch]

    create_table :user_socials do |t|
      t.references :user, foreign_key: true

      t.enum :social_type, enum_type: :social_types, null: false
      t.string :url, null: false

      t.timestamps
    end
  end

  def down
    execute <<-SQL
      DROP TYPE social_types;
    SQL
  end
end

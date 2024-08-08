class UserSocial < ApplicationRecord
  belongs_to :user

  validates :social_type, presence: true, uniqueness: { scope: :user_id, message: 'already exists for this user' }
  validates :url, presence: true, uniqueness: { scope: :user_id, message: 'already exists for this user' }
end

class User < ApplicationRecord
  EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :uid, presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEXP }

  has_many :permissions
  has_many :spaces, through: :permissions
end

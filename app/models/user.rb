class User < ApplicationRecord
  validates :uid, presence: true
  validates :email, presence: true

  has_many :permissions
  has_many :spaces, through: :permissions
end

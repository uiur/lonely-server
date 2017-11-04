class Space < ApplicationRecord
  has_many :images
  has_many :permissions
  has_many :permitted_users, through: :permissions, source: :user

  def viewable_by?(user)
    permitted_users.include?(user)
  end
end

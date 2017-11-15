class Space < ApplicationRecord
  has_many :images
  has_many :permissions
  has_many :permitted_users, through: :permissions, source: :user
  has_one :space_setting, dependent: :destroy

  def viewable_by?(user)
    permitted_users.include?(user)
  end

  def editable_by?(user)
    viewable_by?(user)
  end
end

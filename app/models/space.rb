class Space < ApplicationRecord
  has_many :images
  has_many :permissions
  has_many :permitted_users, through: :permissions, source: :user
  has_one :space_setting, dependent: :destroy

  # private, public are reserved words. so use `visibility_` prefix.
  enum visibility: [:visibility_private, :visibility_public]

  validates :name, presence: true, format: { with: /[a-z0-9_-]+/ }, length: { maximum: 20 }

  def viewable_by?(user)
    permitted_users.include?(user)
  end

  def editable_by?(user)
    viewable_by?(user)
  end
end

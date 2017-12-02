class Space < ApplicationRecord
  has_many :images
  has_many :permissions
  has_many :permitted_users, through: :permissions, source: :user
  has_many :devices
  has_one :space_setting, dependent: :destroy
  has_many :slack_notification_logs, dependent: :destroy

  # private, public are reserved words. so use `visibility_` prefix.
  enum visibility: [:private, :public], _prefix: :visibility

  validates :name, presence: true, format: { with: /[a-z0-9_-]+/ }, length: { maximum: 20 }

  def self.create_with_user(params, user:)
    space = Space.create(params)

    if space.valid?
      space.permissions.create!(user: user)
    end

    space
  end

  def viewable_by?(user)
    visibility_public? || permitted_users.include?(user)
  end

  def editable_by?(user)
    permitted_users.include?(user)
  end

  def slack_slash_token
    Token.first_or_create!(token_type: :slack_slash, secret: Token.generate_secret, space: self)
  end
end

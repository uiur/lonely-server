class Token < ApplicationRecord
  belongs_to :space

  enum token_type: [:slack_slash]

  def self.generate_secret
    SecureRandom.urlsafe_base64(24)
  end
end

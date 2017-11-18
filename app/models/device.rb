class Device < ApplicationRecord
  belongs_to :space

  def self.generate_token
    SecureRandom.base64(24)
  end

  def self.create_with_token(params)
    create(params.merge(token: generate_token))
  end
end

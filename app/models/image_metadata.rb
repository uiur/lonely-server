class ImageMetadata < ApplicationRecord
  belongs_to :image
  enum key: [:face]
end

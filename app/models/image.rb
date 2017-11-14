class Image < ApplicationRecord
  belongs_to :space
  has_many :image_metadata, class_name: 'ImageMetadata'

  after_create :recognize_image

  def self.bucket
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['LONELY_BUCKET_NAME'])
  end

  def s3_object
    self.class.bucket.object(key)
  end

  def key(format: :jpg)
    "#{space.name}/#{timestamp.to_date.to_s}/#{timestamp.strftime('%Y-%m-%d %H:%M:%S')}.#{format}"
  end

  private
  def recognize_image
    # to reduce cost
    if id % 5 == 0
      RecognitionWorker.perform_async(id)
    end
  end
end

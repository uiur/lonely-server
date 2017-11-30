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
    "#{s3_namespace}#{space.name}/#{timestamp.to_date.to_s}/#{timestamp.strftime('%Y-%m-%d %H:%M:%S')}.#{format}"
  end

  # returns public url
  def url
    s3_object.presigned_url(:get, expires_in: 7 * 24 * 60 * 60) # expires in a week
  end

  private
  def recognize_image
    # to reduce cost
    if id % 5 == 0
      RecognitionWorker.perform_async(id)
    end
  end

  def s3_namespace
    ENV['LONELY_BUCKET_NAMESPACE'] || ''
  end
end

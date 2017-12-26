class Image < ApplicationRecord
  belongs_to :space
  has_many :image_metadata, class_name: 'ImageMetadata'

  after_create :recognize_image_if_needed

  RECOGNIZE_INTERVAL_IN_MINUTE = 10

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

  # by default, it's recognized every 10 minutes
  def should_be_recognized?
    return false if ENV['LONELY_DISABLE_WORKER']
    return true if Rails.env.development?

    !in_suspend_time? && timestamp.min % RECOGNIZE_INTERVAL_IN_MINUTE == 0
  end

  private
  def recognize_image_if_needed
    RecognitionWorker.perform_async(id) if should_be_recognized?
  end

  # most people sleeps between 0:00 and 6:59
  def in_suspend_time?
    0 <= timestamp.hour && timestamp.hour <= 6
  end

  def s3_namespace
    ENV['LONELY_BUCKET_NAMESPACE'] || ''
  end
end

class Image < ApplicationRecord
  belongs_to :space

  def self.bucket
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['LONELY_BUCKET_NAME'])
  end

  def self.key(timestamp, format: :jpg)
    "#{timestamp.to_date.to_s}/#{timestamp.strftime('%Y-%m-%d %H:%M:%S')}.#{format}"
  end

  def self.build_s3_object(timestamp)
    bucket.object(key(timestamp))
  end

  def s3_object
    self.class.bucket.object(key)
  end

  def key
    self.class.key(timestamp)
  end
end

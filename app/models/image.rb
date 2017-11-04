class Image < ApplicationRecord
  def self.bucket
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['LONELY_BUCKET_NAME'])
  end

  def s3_object
    self.class.bucket.object(key)
  end

  def key
    "#{created_at.to_date.to_s}/#{created_at.strftime('%Y-%m-%d %H:%M:%S')}.jpg"
  end
end

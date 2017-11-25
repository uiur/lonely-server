class RecognitionWorker
  include Sidekiq::Worker

  def perform(image_id)
    image = Image.find(image_id)
    return if image.image_metadata.where(key: :face).exists?

    f = Tempfile.new('lonely-recognition')
    f.binmode
    f.write(get_body(image).read)
    f.close

    img = Dlib::Image.load(f.path)
    rects = detector.detect(img)

    value =
      if rects.size > 0
        rects.map {|rect| {left: rect.left, top: rect.top, right: rect.right, bottom: rect.bottom } }.to_json
      end

    image.image_metadata.create!(
      key: :face,
      value: value
    )

    if value.present? && should_notify?(image)
      SlackNotificationWorker.perform_async(image.id)
    end
  end

  def get_body(image)
    image.s3_object.get.body
  end

  def should_notify?(image)
    setting = image.space.space_setting
    return false unless setting&.slack_incoming_webhook_url

    SlackNotificationWorker.should_notify?(image)
  end

  private

  def detector
    @detector ||= Dlib::DNNFaceDetector.new('lib/mmod_human_face_detector.dat')
  end
end

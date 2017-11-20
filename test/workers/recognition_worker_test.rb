require 'test_helper'

class RecognitionWorkerTest < ActiveSupport::TestCase
  setup do
    @image = FactoryBot.create(:image)
  end

  test 'creates image metadata' do
    worker = RecognitionWorker.new

    rect = Minitest::Mock.new
    rect.expect :left, 10
    rect.expect :top, 20
    rect.expect :right, 30
    rect.expect :bottom, 40

    rects = [rect]

    worker.stub(:get_body, File.open(Rails.root.join('test/fixtures/human.jpg'))) do
      Dlib::DNNFaceDetector.stub_any_instance(:detect, rects) do
        worker.perform(@image.id)

        assert { @image.image_metadata.where(key: :face).exists? }
        assert { JSON.parse(@image.image_metadata.first.value).size == 1 }
      end
    end
  end

  test 'skip if metadata already exists' do
    worker = RecognitionWorker.new
    @image.image_metadata.create!(key: 'face', value: 'foobar')

    worker.perform(@image.id)
    assert { @image.image_metadata.count == 1 }
  end
end

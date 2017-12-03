require 'test_helper'

class RecognitionWorkerTest < ActiveSupport::TestCase
  setup do
    @image = FactoryBot.create(:image)
  end

  test 'creates image metadata' do
    skip

    worker = RecognitionWorker.new
    response = { face_details: ['foobar'] }
    Aws::Rekognition::Client.stub_any_instance(:detect_faces, response) do
      worker.stub(:get_body, 'foobar') do
        worker.perform(@image.id)

        assert { @image.image_metadata.where(key: :face).exists? }
        assert { @image.image_metadata.first.value == {face_details: ['foobar']}.to_json }
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

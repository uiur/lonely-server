require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  test 'validation' do
    assert { Space.create(name: 'foobar').valid? }

    assert { Space.create.valid? == false }
    assert { Space.create(name: '@@@###////').valid? == false}
    assert { Space.create(name: 'a' * 1000).valid? == false }
  end
end

require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  test 'validation' do
    assert { Space.create(name: 'foobar').valid? }

    assert { Space.create.valid? == false }
    assert { Space.create(name: '@@@###////').valid? == false}
    assert { Space.create(name: 'a' * 1000).valid? == false }
  end

  test 'default values' do
    space = Space.create(name: 'foobar')
    assert { space.visibility_private? }
  end
end

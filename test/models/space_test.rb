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

  test 'visibility is private' do
    space = FactoryBot.create(:space)
    user = FactoryBot.create(:user)
    space.permissions.create!(user: user)

    other = FactoryBot.create(:user)

    assert { space.visibility_private? }
    assert { space.viewable_by?(user) }
    assert { space.editable_by?(user) }

    assert { space.viewable_by?(other) == false }
    assert { space.editable_by?(other) == false }
  end

  test 'visibility is public' do
    space = FactoryBot.create(:space, visibility: Space.visibilities[:visibility_public])
    user = FactoryBot.create(:user)
    space.permissions.create!(user: user)

    other = FactoryBot.create(:user)

    assert { space.visibility_public? }

    assert { space.viewable_by?(user) }
    assert { space.viewable_by?(other) }
    assert { space.viewable_by?(nil) }

    assert { space.editable_by?(user) }
    assert { space.editable_by?(other) == false }
    assert { space.editable_by?(nil) == false }
  end
end

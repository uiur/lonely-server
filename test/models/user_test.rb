require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "validation" do
    assert { User.create(uid: 'abc', email: 'wtf').valid? == false }
    assert { User.create(email: 'uiureo@gmail.com').valid? == false  }

    assert { User.create(uid: 'abc', email: 'uiureo@gmail.com').valid?  }
  end
end

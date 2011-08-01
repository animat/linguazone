require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "can save default teacher factory" do
    assert Factory.build(:teacher).save
  end
end

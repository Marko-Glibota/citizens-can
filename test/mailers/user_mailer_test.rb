require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "request" do
    mail = UserMailer.request
    assert_equal "Request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

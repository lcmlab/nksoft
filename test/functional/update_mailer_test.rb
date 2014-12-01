require 'test_helper'

class UpdateMailerTest < ActionMailer::TestCase
  test "sendmail_change" do
    mail = UpdateMailer.sendmail_change
    assert_equal "Sendmail change", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

require 'test_helper'
require 'confirmation'

class RequestMailerTest < ActionMailer::TestCase
  conf = Confirmation.first
  conf.request # don't understand why test fails without this line
  test "confirmation" do
    mail = RequestMailer.with(confirmation: conf, first_mail: true).confirmation
    assert_equal "Important - Request validation", mail.subject
    assert_equal ["blanche@nains.com"], mail.to
    assert_equal ["no-reply@waitinglist.com"], mail.from
    assert_match "Request", mail.body.encoded
  end

end

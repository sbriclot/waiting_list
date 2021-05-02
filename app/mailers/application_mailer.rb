class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@waitinglist.com'
  layout 'bootstrap-mailer'
end

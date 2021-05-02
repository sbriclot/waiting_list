class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@waitinglist.com'
  layout 'bootstrap-mailer'
end

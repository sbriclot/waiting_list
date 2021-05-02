class EmailInterceptor
  def self.delivering_email(message)
    message.subject = "Test mail"
    message.to = [ 'stephane.briclot@yahoo.fr' ]
  end
end
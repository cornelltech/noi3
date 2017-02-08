class ForwardMailer < ApplicationMailer
  # default template_path: 'devise/mailer'

  def forward_contact(user=nil)
    mail(to: 'enabek@gmail.com', subject: " Registered on Network of Innovators!")
  end
end

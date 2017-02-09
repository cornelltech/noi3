class ForwardMailer < ApplicationMailer
  default template_path: 'devise/mailer'

  def forward_contact(user)
    @user = user
    mail(to: ['admins@thegovlab.org', 'ena@thegovlab.org'], subject: "#{@user.first_name} #{@user.last_name} Registered on Network of Innovators!")
  end
end

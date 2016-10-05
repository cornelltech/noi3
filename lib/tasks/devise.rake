namespace :devise do
  desc "Mass password reset and send email instructions"
  task mass_password_reset: :environment do
    User.all.each do |user|
      User.send_reset_password_instructions user
    end
  end
end
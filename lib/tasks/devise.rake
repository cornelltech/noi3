namespace :devise do
  desc "Mass password reset and send email instructions"
  task mass_password_reset: :environment do
    User.all.each do |user|
    	user.send_reset_password_instructions      
    end
  end
end
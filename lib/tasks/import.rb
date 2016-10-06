# to be run in console

class OldDatabase < ActiveRecord::Base
	self.abstract_class = true
	establish_connection(
		:adapter  => 'postgresql',
		:database => 'naffis',
		:host     => 'localhost',
		:username => 'naffis',
		:password => ''
	)
end

class OldUser < OldDatabase
self.table_name = "users"
end

class OldConference < OldDatabase
self.table_name = "user_conferences"
end

class OldUserExpertiseDomains < OldDatabase
self.table_name = "user_expertise_domains"
end

class OldUserLanguages < OldDatabase
self.table_name = "user_languages"
end

class OldUserSkills < OldDatabase
self.table_name = "user_skills"
end

for user in OldUser.all

# create or update user	
u = User.where(:username => user.username).first
u = User.new() unless u
u.attributes = {
	:first_name => user.first_name,
	:last_name => user.last_name,
	:email => user.email,
	:position => user.position,
	:organization => user.organization,
	:organization_type => user.organization_type,
	:city => user.city,
	:username => user.username,
	:country_code => user.country,
	:picture_path => "/networkofinnovators.org/static/pictures/#{user.id}/#{user.picture_id}",
	:password => 'gasdgagasg235252352asdgsa',
	:password_confirmation => 'gasdgagasg235252352asdgsa' 
}
u.skip_confirmation!
u.save!

# add events to user
conferences = OldConference.where(:user_id => user.id)
for conference in conferences
	if conference.conference == "iodc16"
		e = Event.where(:conference_code => 'IODC')
		u.events << e
	elsif conference.conference == "odrs16"
		e = Event.where(:conference_code => 'ODRS')
		u.events << e
	end
end

# add industries to user
industries = OldUserExpertiseDomains.where(:user_id => user.id)
for industry in industries
	name = industry.name.split(",").first
	i = Industry.where(:name => name).first
	i = Industry.new unless i
	u.industries << i
end

# add user languages
languages = OldUserLanguages.where(:user_id => user.id)
for language in languages
	language = Language.where(:abbreviation => language.locale)
	u.languages << language
end

end

# add user skills (god help us)
y = YAML.load_file('db/questions.yaml')
for category in y
	name = category['id']
	topics = category['topics'] ||= []
	for topic in topics
		topic_name = topic.first.last
		questions = topic['questions'] ||= []
		for question in questions
			label = question['label']
			question_name = "#{name.parameterize}-#{topic_name.parameterize}-#{label.parameterize}"

			user_skills = OldUserSkills.where(:name => question_name)
			for user_skill in user_skills
				old_user = OldUser.find(user_skill.user_id)
				new_user = User.where(:username => old_user.username).first
				if new_user
					new_skill = Skill.where(:short_name => "#{name.parameterize}-#{topic_name.parameterize}",
					:description => question['question'])
					
					if user_skill.level < 0
						new_user.learnables << new_skill	
					else
						new_user.teachables << new_skill
					end
				end
			end

		end
	end
end

require 'faker'
require 'csv'


20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    username: Faker::Internet.user_name,
    picture_path: '/assets/users/128.jpg',
    position: Faker::Company.profession,
    organization: Faker::Company.name,
    organization_type: Faker::Commerce.department,
    city: Faker::Address.city,
    country_code: Faker::Address.country_code
    )
end

# GENERATE CATEGORIES/SKILL AREAS/SKILLS via CSV Questionnaire
csv_file_path = 'db/test-questionnaire-noi.csv'

CSV.foreach(csv_file_path, :headers => true) do |row|
  category = Category.where(name:row[0].downcase).first_or_create
  skill_area = SkillArea.where(name: row[1].downcase, long_name: row[0].parameterize + '-' + row[1].parameterize, category_id: category.id).first_or_create
  skill = Skill.where(short_name:skill_area.long_name, description: row[2], category_id: category.id, skill_area_id: skill_area.id).first_or_create
end

# GENERATE LANGUAGES FROM http://data.okfn.org/data/core/language-codes/r/language-codes.csv

languages_file_path = 'db/language-codes.csv'

CSV.foreach(languages_file_path, :headers => true) do |row|
  Language.create(abbreviation: row[0], name: row[1])
end

# OTHER SEED DATA

50.times do 
  Project.create!(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      url: Faker::Internet.url('example.com'),
      user_id: rand(1..20)
    )
end

# categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prizes", "design thinking", "citizen science"]

# # Create Skill Areas
# areas = ['strategy', 'design', 'engagement', 'implementation', 'readiness', 'impact']

# categories.each do | category |
#   cat = Category.create(name: category)
#   areas.each do | skill_area | 
#     cat.skill_areas << SkillArea.create(name: skill_area, long_name: cat.name.parameterize + '-' + skill_area, category_id: cat.id)
#     end
# end

3.times do
  User.all.each {|user| user.categories << Category.find(rand(1..8)) }
end

Event.create(conference_code: "IODC", name: "3rd International Annual Open Data Conference 2015 ", logo_path: "logo-iodc-web.png")

User.all.each { | user | user.events<< Event.first }

# Add industries to users
industries = 
['Accounting','Agriculture','Animal Rights','Architecture & Planning','Arts & Culture','Aviation & Aerospace','Biotechnology','Business Licensing & Regulation','Chemicals','Children\'s Rights','Civic & Social Organization','Civil Rights & Civil Liberties','Computer Software','Construction & Civil Engineering','Consumer Protection/Debt','Consumer Services','Cyber Security','Design','Disability Rights','Economic Development','Education','Electricity','Employment & Labor','Energy','Environmental Services','Events Services','Executive Office','Facilities Services','Financial Services','Food and Drug','Foreign Affairs','Fund-Raising','Government Efficiency, Transparency & Accountability','Government Relations','Graphic Design','Health Care','Higher Education','Hospitality','Housing, Real Estate & Land Use','Human Resources','Human Rights','Immigration & Citizenship Services','Import & Export','Industrial Automation','Information Services & Technology','Insurance','Intellectual Property and Cyber Rights','International Affairs','International Aid & Development','International Trade','Internet','Judiciary','Juvenile Issues','Law Enforcement','Law & Legal Services','Legislative Policy','Logistics and Supply Chain','Management Consulting','Maritime','Market Research','Media & Communications','Medical Practice','Municipal','Museums and Institutions','National Security & Military','Nonprofit Organization Management','Philanthropy','Political Campaigns/Election','Political Organization','Public Benefits/Social Security','Public Policy','Public Relations','Public Safety & Emergencies','Racial Justice','Regulatory Affairs','Reproductive Rights','Research','Sanitation','Science & Innovation','Social Services','Space','Sports','Tax & Revenue','Telecommunications','Think Tanks','Trade & Investment','Transportation / Trucking / Railroad','Utilities & Water Resources','Women\'s Rights','Other']

industries.each { | industry |  Industry.create(name:industry) }

3.times do
  User.all.each {|user| user.industries << Industry.all.sample }
end

3.times do
  Project.all.each {|project| project.industries << Industry.all.sample }
end

5.times do
  Project.all.each { |project| project.skill_areas << SkillArea.find(rand(1..SkillArea.all.count)) }
end


# SkillArea.all.each { |sa| sa.skills << Skill.create!(short_name: sa.long_name, description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ac ex leo. Quisque ut tortor aliquet, rutrum turpis eu, vestibulum erat. Donec fringilla in ex non vulputate' , category_id: sa.category.id, skill_area_id: sa.id)}

# # Create Teachable and Learnable relationships
User.all.each do |user|
  2.times do 
    Learnable.create(user_id: user.id, skill_id: rand(1..Skill.all.count))
    Teachable.create(user_id: user.id, skill_id: rand(1..Skill.all.count))
  end
end

# Teachable.create(user_id: 1, skill_id:1)
# Teachable.create(user_id: 1, skill_id:2)

User.create!(email: 'admin@example.com', password: 'password', username: 'adminuname', password_confirmation: 'password', :admin => true)
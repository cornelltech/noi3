require 'faker'

20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    picture_path: '128.jpg',
    position: Faker::Company.profession,
    organization: Faker::Company.name,
    organization_type: Faker::Commerce.department,
    city: Faker::Address.city,
    country: Faker::Address.country
    )
end

50.times do 
  Project.create!(
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      user_id: rand(1..20)
    )
end

categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prizes", "design thinking", "citizen science"]

categories.each do | category |
  Category.create(name: category)
end
3.times do
  User.all.each {|user| user.categories << Category.find(rand(1..8)) }
  Project.all.each {|user| user.categories << Category.find(rand(1..8)) }
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

# Create Skill Areas
areas = ['strategy', 'design', 'engagement', 'implementation', 'readiness', 'impact']

areas.each {|skill| SkillArea.create(name: skill)}

# Create Skills
Skill.create(short_name: 'open_data-strategy', description: 'identify what data will help my organization achieve its core mission' , category_id: 1, skill_area_id:1)
Skill.create(short_name: 'open_data-strategy', description: 'use the right infrastructure for making data available' , category_id: 1, skill_area_id:2)
Skill.create(short_name: 'crowdsourcing-implementation', description: ' target the right audience to attract the desired crowd and participation' , category_id: 2, skill_area_id: 3)
Skill.create(short_name: 'crowdsourcing-implementation', description: ' choose a platform to do the crowdsourcing project' , category_id: 2, skill_area_id: 4)
Skill.create(short_name: 'prizes-implementation', description: ' choose from the tools available to run a prize-backed challenge', category_id: 6, skill_area_id:4)
Skill.create(short_name: 'citizen-science-strategy', description: 'identify a compelling goal for a citizen science project', category_id:8, skill_area_id:1)
Skill.create(short_name: 'open_data-readiness', description: 'get organizational approval for opening data' , category_id: 1, skill_area_id:5)
Skill.create(short_name: 'open_data-impact', description: 'express the value proposition of the open data datasets, including what problems can be solved with this data' , category_id: 1, skill_area_id:6)

# Create Teachable and Learnable relationships
User.all.each do |user|
  2.times do 
    Learnable.create(user_id: user.id, skill_id: rand(1..Skill.all.count))
    Teachable.create(user_id: user.id, skill_id: rand(1..Skill.all.count))
  end
end


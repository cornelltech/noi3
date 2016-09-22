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

categories = ["open data", "crowdsourcing", "data science", "community engagement", "lab design", "prized-challenged", "design thinking", "citizen science"]

categories.each do | category |
  Category.create(name: category)
end
3.times do
  User.all.each {|user| user.categories << Category.find(rand(1..8)) }
  Project.all.each {|user| user.categories << Category.find(rand(1..8)) }
end

Event.create(conference_code: "IODC", name: "3rd International Annual Open Data Conference 2015 ", logo_path: "logo-iodc-web.png")

User.all.each { | user | user.events<< Event.first }
FactoryGirl.define do
  factory :user do
    first_name  { Faker::Name.first_name}
    last_name { Faker::Name.last_name}
    email { Faker::Internet.email}
    password  { 'password'}
    username  { Faker::Internet.user_name}
    position  { Faker::Company.profession}
    organization  { Faker::Company.name}
    organization_type { Faker::Commerce.department}
    city  { Faker::Address.city}
    country_code  { Faker::Address.country_code }
    password_confirmation { 'password' }
    confirmed_at  { Time.now }
  end
end
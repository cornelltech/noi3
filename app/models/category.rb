class Category < ApplicationRecord
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :users
  has_many :skills
  has_many :skill_areas, through: :skills
end

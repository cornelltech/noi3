class Category < ApplicationRecord
  has_many :projects, through: :skill_areas
  has_and_belongs_to_many :users
  has_many :skills
  has_many :skill_areas, through: :skills
end

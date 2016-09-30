class Survey < ApplicationRecord
  has_many :skills
  has_many :skill_areas, through: :skills
  has_many :categories, through: :skills
  
end

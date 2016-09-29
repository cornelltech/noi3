class Project < ApplicationRecord
  belongs_to :user
  has_many :categories, through: :skill_areas
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :skill_areas
end

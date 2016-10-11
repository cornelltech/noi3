class Survey < ApplicationRecord
  belongs_to :category
  has_many :skill_areas, through: :category
  has_many :skills, through: :category



end

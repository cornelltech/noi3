class Survey < ApplicationRecord
  belongs_to :category
  has_many :skill_areas, through: :categories
  has_many :skills, through: :categories
  accepts_nested_attributes_for :skills


end

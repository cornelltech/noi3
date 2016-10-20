class Category < ApplicationRecord
  has_one :survey
  has_many :projects, through: :skill_areas
  has_and_belongs_to_many :users
  has_many :skills
  has_many :skill_areas, through: :skills

  def display_name
    return "RCTs" if self.name.downcase == 'rcts'
    self.name.titleize
  end
end


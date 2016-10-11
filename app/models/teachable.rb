class Teachable < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_one :category, :through => :skill
  has_one :skill_area, :through => :skill

  def panel_formatted
    self.skill.description 
  end

end

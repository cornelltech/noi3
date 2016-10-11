class Teachable < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_one :category, :through => :skill

  def panel_formatted
    self.skill.description 
  end

end

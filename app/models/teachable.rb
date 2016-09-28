class Teachable < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  def panel_formatted
    self.skill.description 
  end

end

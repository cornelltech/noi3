class Teachable < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_one :category, :through => :skill
<<<<<<< 0a6d344bfd4f30b26f58769b4dc7e805793fa1de
  has_one :skill_area, :through => :skill
=======
>>>>>>> Add only currently checked expertise/teachables

  def panel_formatted
    self.skill.description 
  end

end

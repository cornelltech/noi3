class Skill < ApplicationRecord
    belongs_to :category
    belongs_to :skill_area
    has_many :teachables


end

class SkillArea < ApplicationRecord
    has_many :skills
    belongs_to :category
    has_and_belongs_to_many :projects
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_and_belongs_to_many :events
  has_and_belongs_to_many :categories #todo: unlink from user
  has_and_belongs_to_many :industries

  has_many :teachables
  has_many :learnables


  def format_expertise
    expertise = []
    self.teachables.each do |skillset| 
      expertise.push({category: skillset.skill.category.name, skill_area:[], skills: []}).uniq!
    end 
    self.teachables.each do |skillset|
      expertise.each do |e|
        if skillset.skill.category.name == e[:category] 
          e[:skill_area] << skillset.skill.skill_area.name
          e[:skills] << skillset.skill.description
        end
        e[:skill_area].uniq!
      end
    end
    # byebug
    expertise
  end


end



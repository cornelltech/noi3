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
      expertise.push({category: skillset.skill.category.name, skill_areas:[], skills: []}).uniq!
    end 
    self.teachables.each do |skillset|
      expertise.each do |e|
        if skillset.skill.category.name == e[:category] 
          e[:skill_areas] << skillset.skill.skill_area.name
          e[:skills] << skillset.skill.description
        end
        e[:skill_areas].uniq!
      end
    end
    expertise
  end

  def format_main_expertise
    expertise = []
    self.teachables.each do |skillset| 
      expertise.push({category: skillset.skill.category.name, skill_areas:[], skills: []}).uniq!
    end 
    self.teachables.each do |skillset|
      expertise.each do |e|
        if skillset.skill.category.name == e[:category] 
          e[:skill_areas] << {area_name: skillset.skill.skill_area.name, area_skills: [].push(skillset.skill.description)}
          # e[:skill_area][:area_children] << skillset.skill.description
        end
        e[:skill_areas].uniq!
      end
    end
    expertise
  end

  def avatar_url
    # FIXME
    # return avatar url of avatar on NOI
    "http://localhost:3000/assets/users/128.jpg"
  end

end



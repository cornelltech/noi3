class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
# paperclip
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "avatars/nopic-avatar1.jpg"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :projects
  has_and_belongs_to_many :events
  has_and_belongs_to_many :categories #todo: unlink from user
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :languages

  has_many :teachables
  has_many :learnables

  attr_accessor :can_teach
  attr_accessor :can_learn
  
  after_create :create_discourse_user  

  def country
    if self.country_code
      country = ISO3166::Country[country_code]
      country.translations[I18n.locale.to_s] || country.name
    else 
      ''
    end
  end

  
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

  def create_discourse_user
    discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    discourse_client.api_username = DISCOURSE_CONFIG[:api_username]

    discourse_client.sync_sso(
      sso_secret: DISCOURSE_CONFIG[:sso_secret],
      name: "#{self.first_name} #{self.last_name}",
      username: "#{self.username}",
      email: "#{self.email}",
      external_id: "#{self.id}")
  end

end


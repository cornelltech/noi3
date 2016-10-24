class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
# paperclip
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "avatars/nopic-avatar1.jpg"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :projects
  has_and_belongs_to_many :events
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :languages

  has_many :categories, through: :teachables
  has_many :skill_areas, through: :teachables

  has_many :teachables
  has_many :learnables

  attr_accessor :can_teach
  attr_accessor :can_learn
  
  after_create :create_discourse_user if Rails.env.production?

  def country
    country = nil
    if self.country_code
      country = ISO3166::Country[country_code]
    end
    if country 
      country.translations[I18n.locale.to_s] || country.name
    else 
      ''
    end
  end

  
def format_expertise
    expertise = []
    self.teachables.includes(:skill,:skill_area,:category).each do |skillset| 
      expertise.push({category: skillset.skill.category.name, skill_areas:skillset.skill.skill_area.name, skills: skillset.skill.description})
    end 
     
    expertise = format_tree(expertise)

    skills_array = []
    expertise.each do |row|
      hsh = {}
      hsh[:category] = row[0]
      hsh[:skill_areas]= []
      hsh[:skill_count] = 0
      row[1].each do |skill|
        hsh[:skill_areas] << {area_skill: skill[0], skills: skill[1]}
        # byebug
        hsh[:skill_count] += skill[1].length
      end
     skills_array << hsh
    end
    skills_array
  end

  def format_tree(cats)
    tree = cats.each_with_object({}) do | row, hsh | 
      category = row[:category]
      skill_area = row[:skill_areas]
      skill = row[:skills]
      hsh[category] ||= {}
      hsh[category][skill_area] ||= []
      hsh[category][skill_area] << skill
    end
    tree
  end

  def create_discourse_user
    discourse_client = DiscourseApi::Client.new(DISCOURSE_CONFIG[:url])
    discourse_client.api_key = DISCOURSE_CONFIG[:api_key]
    discourse_client.api_username = DISCOURSE_CONFIG[:api_username]
    avatar_path = self.picture_path 
    if self.avatar.path
      avatar_path = self.avatar.path
    end
    discourse_client.sync_sso(
      sso_secret: DISCOURSE_CONFIG[:sso_secret],
      name: "#{self.first_name} #{self.last_name}",
      username: "#{self.username}",
      email: "#{self.email}",
      external_avatar_url: "#{avatar_path}",
      external_id: "#{self.email}"
    )
  end

end


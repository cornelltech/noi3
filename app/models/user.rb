class User < ApplicationRecord

  validates_uniqueness_of :username
  # username validations matching discourse
  validates :username, format: {without: /[^\w.-]/, message: "cannot contain spaces and must use alphanumeric characters and underscores only"}
  validates :username, format: {without: /[-_.]{2,}/, message: "cannot have two consecutive special characters"}
  validates :username, length: {minimum: 3, message: "must have at least 3 characters"}
  validates :username, length: {maximum: 15, message: "cannot be longer than 15 characters"}
  validates :username, format: {without: /\.(js|json|css|htm|html|xml|jpg|jpeg|png|gif|bmp|ico|tif|tiff|woff)\z/i, message: "cannot end with a confusing extension"}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
# paperclip
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "avatars/nopic-avatar1.jpg"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :identities, dependent: :destroy
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

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user
    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
# how to verify emails for different providers
      email = auth.info.email 
      user = User.where(:email => email).first if email
      # byebug

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : auth.info.email,
          password: Devise.friendly_token[0,20],
          first_name: auth.info.name,   # assuming the user model has a name
          picture_path: auth.info.image )
        if auth.provider == 'linkedin'
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.email = auth.info.email
          user.position = auth.info.headline.split(" at ")[0]
          user.organization = auth.info.headline.split(" at ")[1]
        elsif auth.provider =='facebook'
          user.first_name =  auth.extra.raw_info.name
        end

      #   user.skip_confirmation!
      #   user.save!
      end
      return user = nil
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

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

  def location
    combined_location = [self.city, self.country]
    if combined_location.reject(&:empty?).length == 2
      combined_location.join(", ")
    else
      combined_location.join("")
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


class Project < ApplicationRecord
  belongs_to :user
  has_many :categories, through: :skill_areas
  has_and_belongs_to_many :industries
  has_and_belongs_to_many :skill_areas
  has_and_belongs_to_many :languages

  has_attached_file :document
  validates :title, presence: true
  validates :description, presence: true
  # validates :url, :format => URI::regexp(%w(http https))
  validates_attachment :document, :content_type => { :content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.ms-excel text/plain text/csv) }
  
  def format_categories
    categories = []
    self.skill_areas.each do |sa|
          categories.push({category: sa.category.name, skill_areas:[]}).uniq!
    end

    categories.each do |c|
      self.skill_areas.each do |sa|
        if sa.category.name == c[:category]
            c[:skill_areas] << sa.name
        end
        c[:skill_areas].uniq!
      end
    end
    categories
  end

end

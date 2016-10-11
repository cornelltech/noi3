class Learnable < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  has_one :category, :through => :skill
end

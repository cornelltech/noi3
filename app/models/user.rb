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

end





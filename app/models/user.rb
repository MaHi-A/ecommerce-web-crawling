class User < ApplicationRecord
  extend FriendlyId
  friendly_id :first_name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :crawls
  has_many :activities
end

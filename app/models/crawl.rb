class Crawl < ApplicationRecord
  extend FriendlyId
  friendly_id :url, use: :slugged

  belongs_to :user

  validates :url, presence: true
  validates :products, presence: true

  serialize :products, Array
end

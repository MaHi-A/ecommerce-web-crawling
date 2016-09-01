class Crawl < ApplicationRecord
  belongs_to :user

  validates :url, presence: true
  validates :products, presence: true

  serialize :products, Array
end

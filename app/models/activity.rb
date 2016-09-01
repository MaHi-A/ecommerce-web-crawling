class Activity < ApplicationRecord
  belongs_to :crawl
  belongs_to :user

  validates_uniqueness_of :crawl_id, scope: :user_id
end

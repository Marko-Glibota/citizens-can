class Law < ApplicationRecord
  has_many :representatives_votes
  has_many :users_votes
  has_many :comments

  validates :url, presence: true
  validates :title, presence: true
  validates :description, presence: true
end

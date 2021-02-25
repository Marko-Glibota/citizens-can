class Law < ApplicationRecord
  has_many :representatives_votes
  has_many :users_votes
  has_many :comments
  acts_as_votable
end

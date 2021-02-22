class UsersVote < ApplicationRecord
  belongs_to :law
  belongs_to :user
  validates :voting_status, presence: true
end

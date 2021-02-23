class RepresentativesVote < ApplicationRecord
  belongs_to :representative
  belongs_to :law

  validates :voting_status, presence: true
end

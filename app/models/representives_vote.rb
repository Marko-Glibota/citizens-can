class RepresentivesVote < ApplicationRecord
  belongs_to :representative
  belongs_to :law
end

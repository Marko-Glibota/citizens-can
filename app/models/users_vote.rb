class UsersVote < ApplicationRecord
  belongs_to :law
  belongs_to :user
end

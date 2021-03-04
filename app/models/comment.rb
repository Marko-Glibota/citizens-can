class Comment < ApplicationRecord
  VOTE = ["pour", "contre"]
  belongs_to :user
  belongs_to :law
  validates :content, presence: true
  validates :voting_status, inclusion: { in: Comment::VOTE }
end

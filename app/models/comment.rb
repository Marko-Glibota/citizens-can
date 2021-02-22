class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :law
  validates :title, :content, :voting_status, presence: true
end

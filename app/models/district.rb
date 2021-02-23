class District < ApplicationRecord
  has_one :representative
  has_many :users
end

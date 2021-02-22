class Representative < ApplicationRecord
  CIV = ["Mme.", "M."]
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :salutation, presence: true, inclusion: { with: CIV }
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :circonscription_ref, presence: true, numericality: { only_integer: true }
  validates :circonscription_num, presence: true, numericality: { only_integer: true }
  validates :city, presence: true
  validates :department, presence: true
  validates :region, presence: true
  validates :representative_ref, presence: true, numericality: { only_integer: true }
  validates :party, presence: true
  validates :first_election, presence: true
  validates :hemicycle_seat, presence: true
end

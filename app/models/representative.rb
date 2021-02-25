class Representative < ApplicationRecord

  belongs_to :district
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :department_code, presence: true
  validates :district_num, presence: true
  validates :addresses, presence: true
  validates :department_name, presence: true
  validates :party_acronym, presence: true
  validates :collaborators, presence: true
  validates :seat_number, presence: true
  validates :start_mandate, presence: true
  validates :birth_date, presence: true
  validates :url_an, presence: true
  validates :id_an, presence: true
end

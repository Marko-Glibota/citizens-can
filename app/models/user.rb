class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments
  has_many :users_votes
  belongs_to :district, optional: true
  acts_as_voter

  validates :email, :password, :first_name, :last_name, :city, :address, :age, :zip, presence: true
  validates :zip, :age, numericality: { only_integer: true }
end

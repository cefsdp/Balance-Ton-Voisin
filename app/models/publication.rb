class Publication < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :clash_requests, dependent: :destroy
  has_many :clashes, through: :clash_request
  #validates :content, presence: true
  #validates :content, uniqueness: true
  #validates :content, length: { minimum: 20 }
end

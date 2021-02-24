class Publication < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  #validates :content, presence: true
  #validates :content, uniqueness: true
  #validates :content, length: { minimum: 20 }
end

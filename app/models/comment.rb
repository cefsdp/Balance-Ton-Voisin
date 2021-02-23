class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :publication

  #validates :content, presence: true
  #validates :content, uniqueness: true
  #validates :content, length: { minimum: 3 }
end

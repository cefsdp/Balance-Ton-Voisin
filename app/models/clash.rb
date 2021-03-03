class Clash < ApplicationRecord
  belongs_to :clash_request
  has_many :votes
  #validates :publication, uniqueness: { scope: :user }
end

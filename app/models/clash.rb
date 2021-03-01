class Clash < ApplicationRecord
  belongs_to :clash_request
  #validates :publication, uniqueness: { scope: :user }
end

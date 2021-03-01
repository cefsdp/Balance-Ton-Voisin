class ClashRequest < ApplicationRecord
	belongs_to :publication
	belongs_to :user
	validates :publication, uniqueness: { scope: :user }
end

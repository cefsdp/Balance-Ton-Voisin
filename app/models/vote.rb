class Vote < ApplicationRecord
  belongs_to :clash
  belongs_to :user
end

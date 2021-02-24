class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  #validates :username, presence: true
  #validates :username, uniqueness: true
  #validates :username, length: { minimum: 3 }
  def profile_picture
    if photo.attached?
      photo.key
    else
      "Profile_picture"
    end
  end
end

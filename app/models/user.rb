class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clash_requests
  has_many :votes

  has_one_attached :photo
  has_many :publications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :recipient

  #validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 3 }
  def profile_picture
    if photo.attached?
      photo.key
    else
      "Profile_picture"
    end
  end

  def ranking
    @user = self
    if @user.score <= -20
      @user.description = "Vraiment un voisin pourri"
    elsif @user.score <= -10
      @user.description = "Karen"
    elsif @user.score <= 10
      @user.description = "Voisin lambda"
    elsif @user.score <= 20
      @user.description = "Organisateur de la fête des voisins"
    else
      @user.description = "Dieu parmi les voisins"
    end
  end
end

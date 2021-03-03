class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clash_requests

  has_one_attached :photo
  has_many :publications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications

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
    @initial = @user.description
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
    @final = @user.description
    ranking_controll
  end

  private

  def ranking_controll
    notification_builder if @initial != @final
  end

  def notification_builder
    @notification = Notification.create(notification_type: "ranking", user_id: @user.id, params: { data: @user.description })
    notificationcable
  end

  def notificationcable
    NotificationChannel.broadcast_to(
      @user,
      txt: `Vous avez gagné un niveau : #{@user}`
    )
  end
end

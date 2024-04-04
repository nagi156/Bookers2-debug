class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローの関連付け
  has_many :active_relationships, class_name: "Relationship",  foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",  foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザー/フォロワーの取得
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  # DM機能
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entries
  
  # 閲覧カウント
  has_many :view_counts, dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50 }

  # ユーザープロフィール画像のメソッド
  def get_profile_image
    (profile_image.attached?)? profile_image : 'no_image.jpg'
  end
   # いいね機能の存在確認
  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end
  # フォロー
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  # フォロー削除
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  # フォローしているかの確認
  def following?(user)
    followings.include?(user)
  end

  # 検索機能
  def self.looks(search, word)
    if search == "perfect"
      User.where(name: word)
    elsif search == "forward"
      User.where("name Like ?", "#{word}%")
    elsif search == "backward"
      User.where("name Like ?", "%#{word}")
    else
      User.where("name Like ?", "%#{word}%")
    end
  end
end

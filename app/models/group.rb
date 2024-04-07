class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user

  validates :name, presence: true
  validates :introduction, presence: true

  # グループの画像を使うため記載
  has_one_attached :group_image

  def get_group_image
    (group_image.attached?)? group_image : 'no_image.jpg'
  end
  # グループ作成した人しか操作できないようにするためのメソッド
  def is_owned_by?(user)
    owner.id == user.id
  end
  # has_many :users, through: :group_users, source: :userの記載があることによって
  # アソシエーションしてUserモデルと関連づいている。
  # GroupUserモデルを介しているため
  # group_usersからuser_idとuser.idが一致するものを探してくるメソッド
  def already_member?(user)
    group_users.exists?(user_id: user.id)
  end

end

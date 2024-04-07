class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true

  # グループの画像を使うため記載
  has_one_attached :group_image

  def get_group_image
    (group_image.attached?)? group_image : 'no_image.jpg'
  end

  def is_owned_by?(user)
    owner.id == user.id
  end

end

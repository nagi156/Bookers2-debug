class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :week_favorites, -> { where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day) }
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  # 検索機能
  def self.looks(search, word)
    if search == "perfect"
      Book.where(title: word)
    elsif search == "forward"
      Book.where("title Like ?", "#{word}%")
    elsif search == "backward"
      Book.where("title Like ?", "%#{word}")
    else
      Book.where("title Like ?", "%#{word}%")
    end
  end
end

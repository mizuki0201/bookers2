class Book < ApplicationRecord
  is_impressionable

  belongs_to :user
  has_many :favorites
  has_many :book_comments
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def favorite_count
    from  = Time.current.at_beginning_of_day
    to    = (from + 6.day).at_end_of_day
    favorites.where(created_at: from...to).length
  end
end

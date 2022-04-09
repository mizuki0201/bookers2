class Chat < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, length: { maximum: 140 }
end

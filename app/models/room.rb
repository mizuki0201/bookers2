class Room < ApplicationRecord
  has_many :chats
  has_many :room_users
end

class Hopper < ApplicationRecord
  belongs_to :user
  has_many :things

  validates :title, presence: true

  def size
    count = self.things.count
    pinned = self.user.pinned_thing
    if !pinned.nil? && pinned.hopper_id == self.id
      count -= 1
    end

    count
  end
end

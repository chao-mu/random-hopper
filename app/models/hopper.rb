class Hopper < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true

  def size
    count = self.tasks.count
    pinned = self.user.pinned_task
    if !pinned.nil? && pinned.hopper_id == self.id
      count -= 1
    end

    count
  end
end

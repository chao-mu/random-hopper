class Hopper < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  belongs_to :pinned_task, class_name: "Task", optional: true

  validates :title, presence: true

  before_destroy :unpin

  def tasks_not_pinned
    self.tasks.where.not(id: self.pinned_task_id)
  end

  def unpin
    User.where(pinned_hopper_id: self.id).update_all(pinned_hopper_id: nil)
  end

  def size
    count = self.tasks.count
    unless self.pinned_task.nil?
      count -= 1
    end

    count
  end
end

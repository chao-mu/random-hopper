class Task < ApplicationRecord
  belongs_to :hopper

  before_destroy :unpin

  def unpin
    User.where(pinned_task_id: self.id).update_all(pinned_task_id: nil)
  end
end

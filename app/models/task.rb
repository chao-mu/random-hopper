class Task < ApplicationRecord
  belongs_to :hopper

  validates :text, presence: true

  before_destroy :unpin

  def unpin
    Hopper.where(pinned_task_id: self.id).update_all(pinned_task_id: nil)
  end
end

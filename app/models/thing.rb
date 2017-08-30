class Thing < ApplicationRecord
  belongs_to :hopper

  before_destroy :unpin

  def unpin
    User.where(pinned_thing_id: self.id).update_all(pinned_thing_id: nil)
  end
end

class AddPinnedThingIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :pinned_thing, references: :things, index: true, null: true
    add_foreign_key :users, :things, column: :pinned_thing_id
  end
end

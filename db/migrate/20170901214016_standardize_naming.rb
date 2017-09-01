class StandardizeNaming < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :pinned_thing_id, :pinned_task_id
    rename_table :things, :tasks
  end
end

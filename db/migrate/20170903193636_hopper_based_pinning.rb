class HopperBasedPinning < ActiveRecord::Migration[5.1]
  class User < ActiveRecord::Base
    belongs_to :pinned_task, class_name: "Task", optional: true
    belongs_to :pinned_hopper, class_name: "Hopper", optional: true
  end

  def self.up
    add_reference :users, :pinned_hopper, references: :hoppers, index: true, null: true
    add_foreign_key :users, :hoppers, column: :pinned_hopper_id

    add_reference :hoppers, :pinned_task, references: :tasks, index: true, null: true
    add_foreign_key :hoppers, :tasks, column: :pinned_task_id

    User.find_each do |user|
      unless user.pinned_task.nil?
        user.pinned_hopper = user.pinned_task.hopper
        user.pinned_hopper.pinned_task = user.pinned_task
        user.save!
      end
    end

    remove_column :users, :pinned_task_id
  end

  def self.down
    add_reference :users, :pinned_task, references: :tasks, index: true, null: true
    add_foreign_key :users, :tasks, column: :pinned_task_id

    User.find_each do |user|
      unless user.pinned_hopper.nil?
        user.pinned_task = user.pinned_hopper.pinned_task
        user.save!
      end
    end

    remove_column :users, :pinned_hopper_id
    remove_column :hoppers, :pinned_task_id
  end
end

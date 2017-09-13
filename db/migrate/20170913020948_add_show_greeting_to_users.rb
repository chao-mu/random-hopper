class AddShowGreetingToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :show_greeting, :boolean, null: false, default: true
  end
end

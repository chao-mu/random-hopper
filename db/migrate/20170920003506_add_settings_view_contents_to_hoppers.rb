class AddSettingsViewContentsToHoppers < ActiveRecord::Migration[5.1]
  def change
    add_column :hoppers, :settings_view_contents, :boolean, default: false, null: false
  end
end

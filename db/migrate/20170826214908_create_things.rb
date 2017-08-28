class CreateThings < ActiveRecord::Migration[5.1]
  def change
    create_table :things do |t|
      t.references :hopper, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end

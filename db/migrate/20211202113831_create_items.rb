class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :size
      t.integer :price
      t.text :link
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end

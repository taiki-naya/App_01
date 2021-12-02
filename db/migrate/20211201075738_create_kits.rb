class CreateKits < ActiveRecord::Migration[5.2]
  def change
    create_table :kits do |t|
      t.string :series
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end

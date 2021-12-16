class CreateLabellingOfItems < ActiveRecord::Migration[5.2]
  def change
    create_table :labelling_of_items do |t|
      t.references :item, foreign_key: true
      t.references :labelable, polymorphic: true

      t.timestamps
    end
  end
end

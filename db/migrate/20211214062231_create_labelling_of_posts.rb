class CreateLabellingOfPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :labelling_of_posts do |t|
      t.references :labelable, polymorphic: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end

class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :home_town
      t.integer :established
      t.text :description
      t.references :league, foreign_key: true

      t.timestamps
    end
  end
end

class AddLinkAndTwitterAcountToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :link, :string
    add_column :teams, :twitter_acount, :string
  end
end

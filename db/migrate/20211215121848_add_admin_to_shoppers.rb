class AddAdminToShoppers < ActiveRecord::Migration[5.2]
  def change
    add_column :shoppers, :admin, :boolean, default: false
  end
end

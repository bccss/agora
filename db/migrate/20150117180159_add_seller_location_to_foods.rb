class AddSellerLocationToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :seller_location, :string
  end
end

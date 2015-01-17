class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.float :price
      t.boolean :for_sale, default: true
      t.integer :seller_id
      t.integer :buyer_id

      t.timestamps
    end

    add_index :foods, :seller_id
    add_index :foods, :buyer_id

  end
end

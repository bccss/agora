class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :food_id

      t.timestamps
    end

    add_index :transactions, :seller_id
    add_index :transactions, :buyer_id
    add_index :transactions, :food_id

  end
end

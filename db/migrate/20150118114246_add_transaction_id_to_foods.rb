class AddTransactionIdToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :transaction_id, :integer
  end
end

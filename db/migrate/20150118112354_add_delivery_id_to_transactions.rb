class AddDeliveryIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :delivery_id, :string
  end
end

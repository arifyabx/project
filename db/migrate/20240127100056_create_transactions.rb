class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.date :transaction_date
      t.string :description
      t.float :amount
      t.string :relates_to_type, limit: 32
      t.integer :relates_to_id 
      t.timestamps
    end
  end
end

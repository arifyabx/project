class CreateInvestors < ActiveRecord::Migration[7.0]
  def change
    create_table :investors do |t|
      t.string :name
      t.string :details
      t.string :mobile_number
      t.float :balance, default: 0.0
      t.json :payload
      t.timestamps
    end
  end
end

class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.string :name
      t.string :details
      t.json :payload
      t.timestamps
    end
  end
end

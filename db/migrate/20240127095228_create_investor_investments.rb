class CreateInvestorInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investor_investments do |t|
      t.belongs_to :investor, index: true
      t.belongs_to :investment, index: true
      t.references :transaction
      t.string :status
      t.timestamps
    end
  end
end

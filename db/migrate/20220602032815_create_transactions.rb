class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :origin_bank,            null: false
      t.string :origin_branch,          null: false
      t.string :origin_account,         null: false
      t.string :target_bank,            null: false
      t.string :target_branch,          null: false
      t.string :target_account,         null: false
      t.string :value_transaction,      null: false
      t.string :datetime_transaction,   null: false

      t.timestamps
    end
  end
end

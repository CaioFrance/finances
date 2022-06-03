class CreateLogTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :log_transactions do |t|
      t.date :transaction_date, null: false
      t.datetime :import_date,      null: false

      t.timestamps
    end
  end
end

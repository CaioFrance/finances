class ChangeColumnDatetimeTransactionInTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :datetime_transaction, :datetime
  end
end

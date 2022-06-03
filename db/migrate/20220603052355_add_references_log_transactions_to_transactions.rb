class AddReferencesLogTransactionsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :log_transactions, null: false, foreign_key: true
  end
end

require 'csv'

require_relative '../models/transaction'
require_relative '../models/log_transaction'

class ImportFileService

  attr_reader :status_file

  @@FILE_INVALID = "Arquivo inválido".freeze

  def get_log_transactions
    log_transactions = LogTransaction.all
  end

  def save_file(file)
    csv = CSV.read(file)

    if is_file_invalid?(csv)
      @status_file = @@FILE_INVALID
      return false
    end

    transactions = transaction_handle(csv)

    if transactions.blank?
      return false
    else
      Transaction.insert_all(transactions)
    end
  
    return true
  end

  def transaction_handle(transactions)
    data = []
    log_transaction = {
      transaction_date: transactions[0][7],
      import_date: Time.now
    }
    if is_valid_transaction?(log_transaction[:transaction_date])
      log = save_log_transaction(log_transaction)
      transactions.each do |row|
        if is_valid_transaction_date?(row[7], log_transaction[:transaction_date])
          data.unshift({
            origin_bank: row[0],
            origin_account: row[1],
            origin_branch: row[2],
            target_account: row[3],
            target_bank: row[4],
            target_branch: row[5],
            value_transaction: row[6],
            datetime_transaction: row[7],
            log_transactions_id: log.id
          })
        else
          delete_log_transaction(log.id)
          return []
        end
      end
    end

    data
  end
  
  def is_file_invalid?(file)
    if file.blank? || file[0][7].nil?
      true
    else
      exist_date?(file)
    end
  end

  private
  # Hash expect => {transaction_date: date, import_date: date}
  def delete_log_transaction(id)
    LogTransaction.delete(id)
  end

  # Hash expect => {transaction_date: date, import_date: date}
  def save_log_transaction(log)
    log[:transaction_date] = date_format(log[:transaction_date])
    LogTransaction.create!(log)
  end

  def exist_date?(file)
    begin
      Date.parse(file[0][7])
      false
    rescue ArgumentError
      true
    end
  end

  def date_format(date)
    Date.parse(date).strftime("%Y/%m/%d")
  end

  def is_valid_transaction?(datetime_transaction)
    data = Transaction.find_by(datetime_transaction: datetime_transaction)
    if data.nil?
      @status_file = "Transações cadastradas com sucesso!"
      return true
    end
    @status_file = "Transações duplicadas, insira outro arquivo!"
    return false
  end

  def is_valid_transaction_date?(date_transaction, date_current)
    date_valid = date_format(date_transaction) == date_format(date_current)

    if date_valid
      true
    else
      @status_file = "Transações inválidas"
      false
    end
  end
end
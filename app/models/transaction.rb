class Transaction < ApplicationRecord

  validates :origin_bank, :origin_account, :origin_branch, presence: true
  validates :target_account, :target_bank, :target_branch, presence: true
  validates :datetime_transaction, :value_transaction, presence: true
end

class Investor < ApplicationRecord
  has_many :investor_investments
  has_many :transactions, class_name: "Transaction", as: :relates_to
end

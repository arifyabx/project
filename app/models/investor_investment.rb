class InvestorInvestment < ApplicationRecord
  belongs_to :investor
  belongs_to :investment
  has_many :transactions, class_name: "Transaction", as: :relates_to
end

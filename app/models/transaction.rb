class Transaction < ApplicationRecord
  belongs_to :relates_to, required: false, polymorphic: true
end

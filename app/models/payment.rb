class Payment < ApplicationRecord
  belongs_to :order

  enum :status, { pending: 0, succeeded: 1, failed: 2, refunded: 3 }

  validates :provider, presence: true

  validates :amounts, presence: true, numericality: { greater_than_or_to: 0 }
end

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :game, optional: true

  has_many :game_keys, dependent: :restrict_with_exception

  validates :product_title, presence: true
  validates :unit_price, :line_total, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end

class GameKey < ApplicationRecord
  belongs_to :game
  belongs_to :order_item, optional: true

  enum :status, { available: 0, reserved: 1, sold: 2, disabled: 3 }

  validates :code, presence: true, uniqueness: true
end

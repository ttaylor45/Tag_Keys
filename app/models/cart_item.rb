class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :game

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validates :game_id, uniqueness: { scope: :cart_id, message: "is already in this cart" }

  def subtotal
    game.current_price * quantity
  end
end

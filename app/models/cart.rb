class Cart < ApplicationRecord
  belongs_to :user, optional: true

  has_many :cart_items, dependent: :destroy

  def total_quantity
    cart_items.sum(:quantity)
  end

  def subtotal
    cart_items.includes(:game).sum(&:subtotal)
  end
end

class CheckoutsController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_cart_has_items

  def new
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:game)
    @provinces = Province.order(:name)

    @checkout = current_user
  end

  def create
  end

  private

  def ensure_cart_has_items
    return if current_cart.cart_items.exists?

    redirect_to cart_path, alert: "Your cart is empty!"

  end
end

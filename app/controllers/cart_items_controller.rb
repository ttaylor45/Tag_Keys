class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [ :update, :destroy ]

  def create
    game = Game.active.find(params[ :game_id ])
    cart_item = current_cart.cart_items.find_by(game: game)

    if cart_item
      cart_item.quantity += 1
    else
      cart_item = current_cart.cart_items.build(
        game: game,
        quantity: 1
      )
    end

    if cart_item.save
      redirect_to cart_path, notice: "#{game.title} was added to your cart."
    else
      redirect_back fallback_location: game_path(game), alert: cart_item.errors.full_messages.to_sentence
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: "Cart quantity has been updated."

    else
      redirect_to cart_path, alert: @cart_item.errorsfull_messages.to_sentence
    end
  end

  def destroy
    game_title = @cart_item.game.title
    @cart_item.destroy

    redirect_to cart_path, notice: "#{game_title} was removed from your cart."
  end

  private

  def set_cart_item
    @cart_item = current_cart.cart_items.find(params[ :id ])
  end

  def cart_item_params
    params.require(:cart_item).permit(quantity)
  end
end

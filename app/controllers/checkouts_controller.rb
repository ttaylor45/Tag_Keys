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
    @cart = current_cart
    province = Province.find(checkout_params[:province_id])

    order = current_user.orders.build(
      province: province,
      order_number: generate_order_number,
      status: :pending,
      address_line_1: checkout_params[:address_line_1],
      address_line_2: checkout_params[:address_line_2],
      city: checkout_params[:city],
      postal_code: checkout_params[:postal_code],
      province_name: province.name
    )

    order.calculate_totals(subtotal: @cart.subtotal)

    ActiveRecord::Base.transaction do
      order.save!

      @cart.cart_items.includes(:game).each do |cart_item|
        order.order_items.create!(
          game: cart_item.game,
          product_title: cart_item.game.title,
          unit_price: cart_item.game.current_price,
          quantity: cart_item.quantity,
          line_total: cart_item.subtotal
        )
      end

      save_customer_address(province) if save_address?

      @cart.cart_items.destroy_all
      session.delete(:cart_id)
    end

    redirect_to order_path(order),
                notice: "Your order was placed successfully."
  rescue ActiveRecord::RecordInvalid => error
    @cart_items = @cart.cart_items.includes(:game)
    @provinces = Province.order(:name)

    flash.now[:alert] = error.record.errors.full_messages.to_sentence
    render :new, status: :unprocessable_entity
  end

  private

  def checkout_params
    params.permit(
      :first_name,
      :last_name,
      :address_line_1,
      :address_line_2,
      :city,
      :province_id,
      :postal_code,
      :save_address
    )
  end

  def save_address?
    ActiveModel::Type::Boolean.new.cast(checkout_params[:save_address])
  end

  def save_customer_address(province)
    current_user.update!(
      first_name: checkout_params[:first_name],
      last_name: checkout_params[:last_name],
      address_line_1: checkout_params[:address_line_1],
      address_line_2: checkout_params[:address_line_2],
      city: checkout_params[:city],
      postal_code: checkout_params[:postal_code],
      province: province
    )
  end

  def generate_order_number
    loop do
      number = "TAG-#{Time.current.strftime('%Y%m%d')}-#{SecureRandom.hex(3).upcase}"

      return number unless Order.exists?(order_number: number)
    end
  end

  def ensure_cart_has_items
    return if current_cart.cart_items.exists?

    redirect_to cart_path,
                alert: "Your cart is empty."
  end
end
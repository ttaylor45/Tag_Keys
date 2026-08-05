class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes


  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_cart

  def authenticate_admin_user!
    authenticate_user!

    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to reach the dashboard!"
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [ :username ]
    )

    devise_parameter_sanitizer.permit(
      :account_update, keys: [ :username, :first_name, :last_name, :address_line_1, :address_line_2,
    :city, :postal_code, :province_id ]
    )
  end

  private

  def current_cart
    return unless user_signed_in?

    cart = Cart.find_by(id: session[:cart_id])

    if cart.nil? || cart.user_id != current_user.id
      cart = current_user.cart || current_user.create_cart!
      session[:cart_id] = cart.id
    end
    cart
  end
end

class Game < ApplicationRecord
  belongs_to :category
  has_many :game_genres, dependent: :destroy
  has_many :genres, through: :game_genres
  has_many :cart_items, dependent: :restrict_with_exception
  has_many :game_keys, dependent: :restrict_with_exception

  validates :steam_app_id, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }
  validates :title, :description, :developer, :publisher, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validate :sale_price_must_be_lower_than_price

  scope :active, -> { where(active: true) }
  scope :featured, -> { where(featured: true) }

  scope :on_sale, lambda {
    where.not(sale_price: nil)
         .where("sale_price < price")
  }

  def on_sale?
    sale_price.present? && sale_price < price
  end

  def current_price
    on_sale? ? sale_price : price
  end

  private

  def sale_price_must_be_lower_than_price
    return if sale_price.blank? || price.blank?
    return if sale_price < price

    errors.add(:sale_price, "must be lower than the regular price")
  end
end

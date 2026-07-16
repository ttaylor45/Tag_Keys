class Order < ApplicationRecord
  has_many :order_items, dependent: destroy
  has_one :payment, dependent: destroy

  belongs_to :user
  belongs_to :province

  enum :status, { pending: 0, unpaid: 1, paid: 2, completed: 3, cancelled: 4 }

  validates :order_number, presence: true, uniqueness: true
  validates :address_line_1, :city, :postal_code, :province_name, presence: true
  validates :subtotal, :gst_amount, :pst_amount, :hst_amount, :tax_total, :grand_total, numericality: { greater_than_or_equal_to: 0 }
end

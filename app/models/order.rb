class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy

  belongs_to :user
  belongs_to :province

  enum :status, { pending: 0, unpaid: 1, paid: 2, completed: 3, cancelled: 4 }

  validates :order_number, presence: true, uniqueness: true
  validates :address_line_1, :city, :postal_code, :province_name, presence: true
  validates :subtotal, :gst_amount, :pst_amount, :hst_amount, :tax_total, :grand_total, numericality: { greater_than_or_equal_to: 0 }

  def calculate_totals(subtotal:)
    self.subtotal = subtotal.to_d.round(2)

    self.gst_rate = province.gst_rate.to_d
    self.pst_rate = province.pst_rate.to_d
    self.hst_rate = province.hst_rate.to_d

    self.gst_amount =
      (self.subtotal * gst_rate).round(2)

    self.pst_amount =
      (self.subtotal * pst_rate).round(2)

    self.hst_amount =
      (self.subtotal * hst_rate).round(2)

    self.tax_total =
      (gst_amount + pst_amount + hst_amount).round(2)

    self.grand_total =
      (self.subtotal + tax_total).round(2)
  end

def self.ransackable_attributes(auth_object = nil)
  [
    "id",
    "user_id",
    "province_id",
    "order_number",
    "status",
    "subtotal",
    "gst_rate",
    "pst_rate",
    "hst_rate",
    "gst_amount",
    "pst_amount",
    "hst_amount",
    "tax_total",
    "grand_total",
    "address_line_1",
    "address_line_2",
    "city",
    "postal_code",
    "province_name",
    "paid_at",
    "created_at",
    "updated_at"
  ]
end

def self.ransackable_associations(auth_object = nil)
  [
    "user",
    "province",
    "order_items",
    "payment"
  ]
end
end

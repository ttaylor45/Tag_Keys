class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :registerable, :rememberable, :validatable
  belongs_to :province, optional: true

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :restrict_with_exception

  enum :role, {
    customer: 0,
    admin: 1
  }

  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  validates :role, presence: true

  validates :postal_code,
            format: {
              with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/,
              message: "must be a valid Canadian postal code"
            },
            allow_blank: true
def self.ransackable_attributes(auth_object = nil)
  [
    "id",
    "email",
    "username",
    "first_name",
    "last_name",
    "address_line_1",
    "address_line_2",
    "city",
    "postal_code",
    "province_id",
    "role",
    "created_at",
    "updated_at"
  ]
end

def self.ransackable_associations(auth_object = nil)
  [
    "province",
    "orders"
  ]
end
end

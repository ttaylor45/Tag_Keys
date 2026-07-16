class User < ApplicationRecord
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

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
end

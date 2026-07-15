class Genre < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sesitive: false }
  validates :description, presence: true
end

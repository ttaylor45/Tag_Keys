class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many :games, dependent: :restrict_with_exception

    def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "description",
      "created_at",
      "updated_at"
    ]
    end

  def self.ransackable_associations(auth_object = nil)
    [ "games" ]
  end
end

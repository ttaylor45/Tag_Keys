class PageContent < ApplicationRecord
  validates :page_key, presence: true, uniqueness: true
  validates :title, :body, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "page_key",
      "title",
      "body",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end

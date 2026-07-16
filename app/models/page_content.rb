class PageContent < ApplicationRecord
  validates :page_key, presence: true, uniqueness: true
  validates :title, :body, presence: true
end

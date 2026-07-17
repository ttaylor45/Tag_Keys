class AddHeaderImageUrlToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :header_image_url, :string
  end
end

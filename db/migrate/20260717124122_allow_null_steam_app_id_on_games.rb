class AllowNullSteamAppIdOnGames < ActiveRecord::Migration[8.0]
  def change
    change_column_null :games, :steam_app_id, true
  end
end

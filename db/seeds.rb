# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "httparty"
require "date"

provinces = [
  {
    name: "Manitoba",
    abbreviation: "MB",
    gst_rate: 0.05,
    pst_rate: 0.07,
    hst_rate: 0
  },
  {
    name: "Alberta",
    abbreviation: "AB",
    gst_rate: 0.05,
    pst_rate: 0,
    hst_rate: 0
  },
  {
    name: "British Columbia",
    abbreviation: "BC",
    gst_rate: 0.05,
    pst_rate: 0.07,
    hst_rate: 0
  },
  {
    name: "Saskatchewan",
    abbreviation: "SK",
    gst_rate: 0.05,
    pst_rate: 0.06,
    hst_rate: 0
  },
  {
    name: "New Brunswick",
    abbreviation: "NB",
    gst_rate: 0,
    pst_rate: 0,
    hst_rate: 0.15
  },
  {
    name: "Newfoundland and Labrador",
    abbreviation: "NL",
    gst_rate: 0,
    pst_rate: 0,
    hst_rate: 0.15
  },
  {
    name: "Northwest Territories",
    abbreviation: "NT",
    gst_rate: 0.05,
    pst_rate: 0,
    hst_rate: 0
  },
  {
    name: "Nova Scotia",
    abbreviation: "NS",
    gst_rate: 0,
    pst_rate: 0,
    hst_rate: 0.14
  },
  {
    name: "Nunavut",
    abbreviation: "NU",
    gst_rate: 0.05,
    pst_rate: 0,
    hst_rate: 0
  },
  {
    name: "Ontario",
    abbreviation: "ON",
    gst_rate: 0,
    pst_rate: 0,
    hst_rate: 0.13
  },
  {
    name: "Quebec",
    abbreviation: "QC",
    gst_rate: 0.5,
    pst_rate: 0.09975,
    hst_rate: 0
  },
  {
    name: "Yukon",
    abbreviation: "YT",
    gst_rate: 0.05,
    pst_rate: 0,
    hst_rate: 0
  },
  {
    name: "Prince Edward Island",
    abbreviation: "PE",
    gst_rate: 0.05,
    pst_rate: 0.08,
    hst_rate: 0.15
  }
]

provinces.each do |attributes|
  province = Province.find_or_initialize_by(
    abbreviation: attributes[:abbreviation]
  )

  province.update!(attributes)
end

puts "Seeded #{Province.count} provinces and territories."

categories = [
  {
    name: "Base Game",
    description: "A regular standalone game."
  },
  {
    name: "DLC",
    description: "Downloadable content that extends a game."
  },
  {
    name: "Bundle",
    description: "A collection of games or downloadable content."
  }
]

categories.each do |attributes|
  category = Category.find_or_initialize_by(name: attributes[:name])
  category.update!(attributes)
end

puts "Seeded #{Category.count} categories."

# Store this category so the Steam importer can use it.
base_game_category = Category.find_by!(name: "Base Game")


genres = [
  {
    name: "Adventure",
    description: "Games focused on exploration, story, and discovery."
  },
  {
    name: "Action",
    description: "Games focused on fast-paced combat or player reactions."
  },
  {
    name: "RPG",
    description: "Role-playing games featuring character progression or story choices."
  },
  {
    name: "Strategy",
    description: "Games focused on planning, resource management, and tactical decisions."
  },
  {
    name: "Sports",
    description: "Games based on competitive sports and athletic activities."
  },
  {
    name: "Racing",
    description: "Vehicle racing and driving competitions."
  },
  {
    name: "Puzzle",
    description: "Games focused on logic, problem-solving, and challenges."
  },
  {
    name: "Survival",
    description: "Games focused on gathering resources, crafting, and staying alive."
  },
  {
    name: "Horror",
    description: "Games designed around suspense, fear, and frightening situations."
  },
  {
    name: "FPS",
    description: "First-person shooter games focused on ranged combat."
  },
  {
    name: "Open World",
    description: "Games that provide large worlds with flexible exploration."
  },
  {
    name: "Indie",
    description: "Games created by independent developers or smaller studios."
  }
]

genres.each do |attributes|
  genre = Genre.find_or_initialize_by(name: attributes[:name])
  genre.update!(attributes)
end

puts "Seeded #{Genre.count} genres."

puts "Starting Steam game import..."

steam_app_ids = [
  1091500, # Cyberpunk 2077
  1245620, # Elden Ring
  292030,  # The Witcher 3
  271590,  # Grand Theft Auto V
  1174180  # Red Dead Redemption 2
]

steam_app_ids.each do |app_id|
  begin
    puts "Requesting Steam App ID #{app_id}..."

    response = HTTParty.get(
      "https://store.steampowered.com/api/appdetails",
      query: {
        appids: app_id,
        cc: "ca",
        l: "english"
      },
      timeout: 15
    )

    unless response.success?
      puts "Skipped #{app_id}: HTTP status #{response.code}"
      next
    end

    result = response.parsed_response[app_id.to_s]

    unless result&.dig("success")
      puts "Skipped #{app_id}: Steam returned success false"
      next
    end

    data = result["data"]

    unless data["type"] == "game"
      puts "Skipped #{app_id}: Steam item is not a game"
      next
    end

    price_information = data["price_overview"]

    price =
      if data["is_free"]
        0
      elsif price_information.present?
        price_information["final"].to_i / 100.0
      else
        0
      end

    release_date_text = data.dig("release_date", "date")

    release_date =
      begin
        Date.parse(release_date_text) if release_date_text.present?
      rescue Date::Error
        nil
      end

    description =
      data["short_description"].presence ||
      data["detailed_description"].presence ||
      "No description is currently available."

    description =
      ActionView::Base.full_sanitizer.sanitize(description)

    game = Game.find_or_initialize_by(
      steam_app_id: app_id
    )

    game.assign_attributes(
      title: data["name"],
      description: description,
      price: price,
      developer: Array(data["developers"]).join(", "),
      publisher: Array(data["publishers"]).join(", "),
      release_date: release_date,
      header_image_url: data["header_image"],
      active: true,
      featured: false,
      category: base_game_category
    )

    game.save!

    imported_genres = Array(data["genres"]).filter_map do |steam_genre|
      genre_name = steam_genre["description"].presence

      next if genre_name.blank?

      genre = Genre.find_or_initialize_by(name: genre_name)

      if genre.description.blank?
        genre.description = "Genre information imported from Steam."
      end

      genre.save!
      genre
    end

    game.genres = imported_genres

    puts "Imported #{game.title}"

    sleep 1
  rescue StandardError => error
    puts "Failed to import Steam App ID #{app_id}:"
    puts "#{error.class}: #{error.message}"
  end
end

puts "Steam game import complete."
puts "Total games: #{Game.count}"

page_contents = [
  {
    page_key: "about",
    title: "About TAG Keys",
    body: "TAG Keys is an educational Canadian digital game catalogue."
  },
  {
    page_key: "contact",
    title: "Contact TAG Keys",
    body: "Contact information will be updated through the administration area."
  }
]

page_contents.each do |attributes|
  page = PageContent.find_or_initialize_by(
    page_key: attributes[:page_key]
  )

  page.update!(attributes)
end

puts "Seeded #{PageContent.count} editable pages."

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
    gst_rate: 0.05,
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
    gst_rate: 0,
    pst_rate: 0,
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
  },
  {
    name: "Free-to-Play",
    description: "A standalone game that customers can access without an initial purchase."
  }
]

categories.each do |attributes|
  category = Category.find_or_initialize_by(
    name: attributes[:name]
  )

  category.update!(attributes)
end

puts "Seeded #{Category.count} categories."

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

puts "Starting Steam product import..."

SteamImporter.new.import_products(
  base_games: 60,
  free_games: 10,
  dlcs: 20,
  bundles: 10
)

puts "Steam product seeding finished."
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

puts
puts "Database seeding complete."
puts "Provinces and territories: #{Province.count}"
puts "Categories: #{Category.count}"
puts "Genres: #{Genre.count}"
puts "Base games: #{Game.joins(:category).where(categories: { name: "Base Game" }).count}"
puts "DLCs: #{Game.joins(:category).where(categories: { name: "DLC" }).count}"
puts "Bundles: #{Game.joins(:category).where(categories: { name: "Bundle" }).count}"
puts "Total products: #{Game.count}"
puts "Editable pages: #{PageContent.count}"

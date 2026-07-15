# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

provinces =[
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
    description: "Just a regular game with nothing attached"
  },
  {
    name: "DLC",
    description: "Downloadable content that will extend the game"
  },
    {
    name: "Bundle",
    description: "A collection of steam games or seperate game content"
  }
]

categories.each do |attributes|
  category = Category.find_or_initialize_by(name: attributes[:name])
  category.update!(attributes)
end

puts "Seeded #{Category.count} categories."

genres = [
  {
    name: "Adventure",
    description: "Games focused on exploration, story and discovery."
  },
  {
    name: "Action",
    description: "Games focused on fast-paced combat or player reactions."
  },
  {
    name: "RPG",
    description: "Role-playing games that features character progression or story choices."
  },
  {
    name: "Strategy",
    description: "Games that is focused on planning, resource management, and tactical decisions."
  },
  {
    name: "Sports",
    description: "Games based on competitive sports and athletic activities."
  },
  {
    name: "Racing",
    description: "Vehicle racing and driving competition."
  },
  {
    name: "Puzzle",
    description: "Games that tailors to logic, problem solving, and challenges."
  },
  {
    name: "Survival",
    description: "Focused on resources gathering, crafting, and staying alive."
  },
  {
    name: "Horror",
    description: "Games that is designed around suspense, fear, and jumpscares!"
  },
  {
    name: "FPS",
    description: "First-Person-Shooter games on ranged combat."
  },
  {
    name: "Open World",
    description: "This provides large worlds with flexible explorations."
  },
  {
    name: "Indie",
    description: "Games created by developers or small studios."
  }
]

genres.each do |attributes|
  genre = Genre.find_or_initialize_by(name: attributes[:name])
  genre.update!(attributes)
end

puts "Seeded #{Genre.count} genres."

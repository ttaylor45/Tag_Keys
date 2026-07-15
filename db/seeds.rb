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

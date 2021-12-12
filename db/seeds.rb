# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

application_1 = Application.create!(applicant_name: "Mike Sloan", street_address: "134 Willow Lane", city: "Boulder", state: "CO", zip_code: "80034", description: "I'd be good because I love pets", application_status: "pending")

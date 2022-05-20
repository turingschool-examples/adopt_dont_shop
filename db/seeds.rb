# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Application.destroy_all

application = Application.create!(name: 'Debbie', street_address: '1234 dog way', city: "San Francisco", state: 'CA', zip_code: 66012, description: 'I love dogs', application_status: 'Accepted')

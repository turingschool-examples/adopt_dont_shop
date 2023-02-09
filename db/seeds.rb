# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@application = Application.create!(name: 'John', street_address: '1 Sesame St', city: 'Denver',
state: 'CO', zip_code: 12345, description: 'I like dogs', status: 'Pending')
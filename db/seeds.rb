# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

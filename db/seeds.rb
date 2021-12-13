# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.destroy_all
applicant_1 = Application.create!(name: 'John Smith', street: '123 Oak Lane', city: 'Anytown', state: 'CO', zip: 12345, description: 'I love dogs', status: 'In Progress')
applicant_2 = Application.create!(name: 'Mike Jones', street: '345 Peach Street', city: 'Thistown', state: 'PA', zip: 23456, description: 'Dogs love me', status: 'Pending')
applicant_3 = Application.create!(name: 'Lisa Wilson', street: '567 Main Lane', city: 'Thattown', state: 'MA', zip: 34567, description: 'Dogs are my best friends', status: 'In Progress')
applicant_4 = Application.create!(name: 'Mary Wells', street: '789 Park Ave', city: 'Thetown', state: 'MO', zip: 87654, description: 'pets are amazing', status: 'Pending')
applicant_5 = Application.create!(name: 'Isaac Hayes', street: '912 Market Blvd', city: 'Motown', state: 'MI', zip: 98765, description: 'Who would not want a pet', status: 'In Progress')


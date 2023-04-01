# require 'rails_helper'

# RSpec.describe Application, type: :model do
#   describe 'relationships' do
#     it { should belong_to :pets }
#   end

#   describe 'class methods' do
#     let!(:application_1) { Application.create!(name: 'Bob', street_address: '1234 Southeast St',
#       city: 'San Francisco', state: 'CA', zip_code: 12345,
#       description: 'Wants a dog', name_of_pet: 'Lobster', application_status: "In Progress") }

#     let!(:application_2) { Application.create!(name: 'Sally', street_address: '4321 Bridge Way',
#       city: 'San Francisco', state: 'CA', zip_code: 54321,
#       description: 'Would like a siamese cat', name_of_pet: 'Lucille Bald', application_status: "In Progress") }

#     let!(:application_3) { Application.create!(name: 'Fred', street_address: '376 Monroe St',
#       city: 'Los Angeles', state: 'CA', zip_code: 67890,
#       description: 'Interested in sibling pets', name_of_pet: 'Beethoven', application_status: "In Progress") }
     
#     it '::search_pet' do
#       expect(application_1.search_pet).to eq('Lobster')
#     end
#   end
# end
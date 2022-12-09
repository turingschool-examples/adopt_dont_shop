# require 'rails_helper'

# RSpec.describe Application, type: :model do
#   describe "relationships" do
#     it { should have_many :application_pets }
#     it { should have_many(:pets).through(:application_pets) }
#   end

#   describe "#full_address" do
#     it 'can create a full address' do
#       application_1 = Application.create!(
#         name: "Bob",
#         street_address: "123 Leaf Street",
#         city: "Denver",
#         state: "CO",
#         zip_code: 80020,
#         description: "Work from home",
#         status: "In Progress"
#       )

#       expect(application_1.full_address).to eq("123 Leaf Street, Denver, CO 80020")
#     end
#   end
# end
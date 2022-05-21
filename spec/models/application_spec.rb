require 'rails_helper'

RSpec.describe Application, type: :model do
	let!(:shelter) {Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
	let!(:app_1) {Application.create(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)}
	let!(:app_2) {Application.create(name: 'Jenn', street_address: '2 Wildflower Lane', city: 'Aurora', state: 'CO', zip_code: 80010)}
	let!(:pet_1) {Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
	let!(:pet_2) {Pet.create!(name: "Zucchini", breed: 'weenie dog', age: 7, adoptable: true, shelter_id: shelter.id)}

	let!(:pet_application_1) {PetApplication.create(pet_id: pet_2.id, application_id: app_1.id)}

	describe 'relationships' do
		it { should have_many(:pet_applications)}
		it { should have_many(:pets).through(:pet_applications)}
	end

	describe 'validations' do
		it {should validate_presence_of(:name)}
		it {should validate_presence_of(:street_address)}
		it {should validate_presence_of(:city)}
		it {should validate_presence_of(:state)}
		it {should validate_presence_of(:zip_code)}
	end

	describe "instance methods" do
		it "returns true if the application has 1 or more pets" do
			expect(app_1.has_pets?).to eq(true)
			expect(app_2.has_pets?).to eq(false)
		end
	end
end

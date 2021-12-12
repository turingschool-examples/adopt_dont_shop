require 'rails_helper'

RSpec.describe 'surveys view' do

  let(:shelter_1) {Shelter.create!(
    foster_program: true, 
    name: "Aspen Grove", 
    city: "Fort Collins", 
    rank: 1)}

  let(:survey_1) {Survey.create!(
    name: "John Napier", 
    street_address: "936 Akin Ave.", 
    city: "Fort Collins", 
    state: "CO.", 
    zip_code: 80521, 
    description: "Good Owner", 
    status: "Pending")}

  let!(:pet_1) {survey_1.pets.create!(
    adoptable: true, 
    age: 1, 
    breed: "Boston Terrier", 
    name: "Zelma", 
    shelter_id: shelter_1.id)}

  let!(:pet_2) {survey_1.pets.create!(
    adoptable: true, 
    age: 13, 
    breed: "Tabby Cat", 
    name: "Mazzy", 
    shelter_id: shelter_1.id)}

  it 'can show the application attributes in a form' do 
    visit "/surveys/#{survey_1.id}"

    expect(page).to have_content(survey_1.name)
    expect(page).to have_content(survey_1.street_address)
    expect(page).to have_content(survey_1.city)
    expect(page).to have_content(survey_1.state)
    expect(page).to have_content(survey_1.zip_code)
    expect(page).to have_content(survey_1.description)
    expect(page).to have_content(survey_1.status)
    expect(page).to have_link(pet_1.name)
    expect(page).to have_link(pet_2.name)
  end

  it 'can click the pet link and be taken to the pet show page' do 
    visit "/surveys/#{survey_1.id}"

    click_link "#{pet_1.name}"

    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end
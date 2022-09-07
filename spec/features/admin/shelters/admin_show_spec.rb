require 'rails_helper'

RSpec.describe 'admin show page' do
  before :each do
    @fontaine = Shelter.create!(name: 'Fontainebleu Institute of Varmint Husbandry', city: 'Golden, CO', foster_program: true, rank: 6)
  end

  it 'displays the shelter full name and address' do
    visit "/admin/shelters/#{@fontaine.id}"
    expect(page).to have_content(@fontaine.name)
    expect(page).to have_content(@fontaine.city)
  end
end
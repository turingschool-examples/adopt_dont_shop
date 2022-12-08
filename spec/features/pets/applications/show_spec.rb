require 'rails_helper'

RSpec.describe 'the pet application show page' do
  it 'has the name, address, description, names of pets, and status displayed' do
    
    
    visit "/applications/#{application.id}"

    expect(page).to have_content()
    expect(page).to have_content()
    expect(page).to have_content()
    expect(page).to have_content()
    expect(page).to have_content()
  end

  it 'has links to each pet via the name of the pet on the applicaiton' do
    visit "/applications/#{application.id}"

    expect(page).to have_link "#{pet1.name}", href: "/pets/:pet_id"
    expect(page).to have_link "#{pet2.name}", href: "/pets/:pet_id"
    expect(page).to have_link "#{pet3.name}", href: "/pets/:pet_id"
  end
end
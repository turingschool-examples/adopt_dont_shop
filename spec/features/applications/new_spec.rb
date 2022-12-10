require 'rails_helper'

RSpec.describe 'new application page' do
  it 'links to the new page from the pets index page' do
    visit '/pets'

    click_link 'Start an Application'
    expect(current_path).to eq('/applications/new')
  end

  it 'can create a new application' do 
    visit '/applications/new'

    fill_in('name', with: "Billy")
    fill_in('street_address', with: "323 Seventh St")
    fill_in('city', with: "Redlands")
    fill_in('state', with: "CA")
    fill_in('zip_code', with: "92373")
    fill_in('description', with: "I love cute pets!")

    click_button 'submit'

    new_application_id = Application.last.id

    expect(current_path).to eq("/applications/#{new_application_id}")
    expect(page).to have_content("Billy")
    expect(page).to have_content("323 Seventh St")
    expect(page).to have_content("Redlands")
    expect(page).to have_content("CA")
    expect(page).to have_content("92373")
  end

  it 'will only accept fully filled out applications' do
    visit '/applications/new'

    fill_in('name', with: "Billy")
    fill_in('street_address', with: "323 Seventh St")
    fill_in('city', with: "Redlands")
    fill_in('state', with: "CA")
    # fill_in('zip_code', with: "92373")

    click_button 'submit'

    expect(page).to have_content("Zip code can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(current_path).to eq('/applications') 
  end
end
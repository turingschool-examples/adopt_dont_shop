require 'rails_helper'

RSpec.describe 'the new application page' do 
  it "displays a fillable form" do 
    visit '/applications/new' 

    expect(page).to have_selector(:css, 'form')
    expect(page).to have_content('New Application')
    expect(page).to have_content('Name')
    expect(page).to have_content('In Progress')
    expect(page).to have_content('Street')
    expect(page).to have_content('City')
    expect(page).to have_content('State')
    expect(page).to have_content('Zipcode')

    expect(page).to have_button('Submit')
  end

  it "doesn't allow submission of incomplete form" do 
    visit '/applications/new'
  
    fill_in "street", with: "5155 Heritage Lane"
    fill_in "city", with: "Alexandria"
    fill_in "state", with: "VA"
    fill_in "zipcode", with: "22314"

    click_on "Submit"

    expect(page.current_path).to eql("/applications/new")
    expect(page).to have_content("Please fill missing fields")
  end

  it "redirect to the newly created application upon creation" do
    visit '/applications/new'

    fill_in "applicant", with: "Hamada"
    fill_in "street", with: "5155 Heritage Lane"
    fill_in "city", with: "Alexandria"
    fill_in "state", with: "VA"
    fill_in "zipcode", with: "22314"

    click_on "Submit"

    expect(page.current_path).to eql("/applications/#{Application.last.id}")
  end
end
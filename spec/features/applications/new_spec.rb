require "rails_helper"

RSpec.describe "Applications New Page" do
  describe "As a visitor" do
    describe "When I visit new application page" do
      it 'has a form you can fill out, hit submit, and be taken to new applications show page' do
        visit '/applications/new'
        expect(page).to have_field(:name)
        expect(page).to have_field(:street_address)
        expect(page).to have_field(:city)
        expect(page).to have_field(:state)
        expect(page).to have_field(:zip_code)
        expect(page).to have_field(:description)

        fill_in :name, with: "Brian"
        fill_in :street_address, with: "123 Road lane"
        fill_in :city, with: "Boulder"
        fill_in :state, with: "Colorado"
        fill_in :zip_code, with: "12345"
        fill_in :description, with: "I have a large back yard"

        click_button "Create Application"

        expect(Application.all.size).to eq(1)
        expect(current_path).to eq("/applications/#{Application.first.id}")
        expect(page).to have_content("Brian")
      end
    end
  end
end
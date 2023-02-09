require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    @application = Petition.create!(name: 'Pete', street_address: "249 Tition Dr.", city: "Denver", state: "Colorado", zip_code: 80823)
  end

  describe 'the application new' do
    it 'renders the new form' do
      visit "/petitions/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  # describe 'the veterinarian create' do
  #   context 'given valid data' do
  #     it 'creates the vet and redirects to the veterinary offices vet index' do
  #       visit "/veterinary_offices/#{@vet_office.id}/veterinarians/new"

  #       fill_in 'Name', with: 'Dr. Burstyn'
  #       fill_in 'Review rating', with: 10
  #       check 'On call'
  #       click_button 'Save'
  #       expect(page).to have_current_path(
  #         "/veterinary_offices/#{@vet_office.id}/veterinarians"
  #       )
  #       expect(page).to have_content('Dr. Burstyn')
  #     end
  #   end

  #   context 'given invalid data' do
  #     it 're-renders the new form' do
  #       visit "/veterinary_offices/#{@vet_office.id}/veterinarians/new"

  #       click_button 'Save'
  #       expect(page).to have_current_path(
  #         "/veterinary_offices/#{@vet_office.id}/veterinarians/new"
  #       )
  #       expect(page).to have_content("Error: Name can't be blank, Review rating can't be blank, Review rating is not a number")
  #     end
  #   end
  # end
end

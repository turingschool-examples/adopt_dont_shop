require 'rails_helper'

RSpec.describe 'admin shelters index' do
  describe 'when i visit admin shelters index' do
    before do
      @shelter1 = create(:shelter, name: 'AAA')
      @shelter1 = create(:shelter, name: 'AAA')
      @shelter2 = create(:shelter, name: 'BBB')
      @shelter3 = create(:shelter, name: 'CCC')
      @pet1 = create(:pet, shelter_id: @shelter1.id)
      @pet2 = create(:pet, shelter_id: @shelter2.id)
      @pet3 = create(:pet, shelter_id: @shelter3.id)
      @application1 = create(:application, status: "Pending")
      @application2 = create(:application)
      @application1.pets << @pet1
      @application2.pets << @pet2

      visit admin_shelters_path
    end

    it 'lists shelters in reverse alphabetical order' do
      expect(@shelter3.name).to appear_before(@shelter2.name)
      expect(@shelter2.name).to appear_before(@shelter1.name)
    end

    it 'i see a section for pending applications' do
      within('#pending') do
        expect(page).to have_content('Shelters with Pending Applications')
        expect(page).to have_content(@shelter1.name)
        expect(page).to_not have_content(@shelter2.name)
        expect(page).to_not have_content(@shelter3.name)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe 'Admin Shelters index spec' do
  before :each do
    @ddfl = Shelter.create!(name: "Denver Dumb Friends League", foster_program: true, city: "Denver", rank: 5)
    @max = Shelter.create!(name: "Max Fund", foster_program: true, city: "Denver", rank: 5)
  end

    it 'will show all shelters in reverse alphbetical order' do
      visit "/admin/shelters"
save_and_open_page
      expect(@max.name).to appear_before(@ddfl.name)
    end
end

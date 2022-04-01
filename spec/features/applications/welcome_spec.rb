require 'rails_helper'


RSpec.describe 'the applications index' do
  it 'has a welcome message ' do
    visit "/"
    expect(page).to have_content("Adopt, don't shop!")
    # expect(page).to have_link('/pets')
    # expect(page).to have_link('/shelters')
    # expect(page).to have_link('/veterinarians')
    # expect(page).to have_link('/veterinary_offices')
  end
end

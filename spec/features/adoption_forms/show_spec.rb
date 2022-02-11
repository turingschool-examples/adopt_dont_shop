require 'rails_helper'

RSpec.describe 'Pet adoption application show page', type: :feature do
  it 'does thing' do
    form = create(:adoption_form)
    visit "/adoption_forms/#{form.id}"
    save_and_open_page
  end
end

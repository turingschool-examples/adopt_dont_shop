require 'rails_helper'

RSpec.describe 'Application show page', type: :feature do
  xit 'displays applicants home info' do
    sam = Application.create!(applicant_name: "Sam Neill",
                              address: "123 Wilderpeople Way",
                              city: "Eerie",
                              state: "Colorado",
                              zip_code: 80514,
                              reason: "Lots of love to give",
                              status: "Applied")
    visit "/applications/#{sam.id}"
  end
end

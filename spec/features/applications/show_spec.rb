require 'rails_helper'

RSpec.describe 'Application show page', type: :feature do
  it 'displays applicants home info' do
    sam = Application.create!(applicant_name: "Sam Neill",
                              address: "123 Wilderpeople Way",
                              city: "Eerie",
                              state: "Colorado",
                              zip_code: 80514,
                              reason: "Lots of love to give",
                              status: "Applied")
    sam2 = Application.create!(applicant_name: "Samantha Neill",
                              address: "123 Wilder Way",
                              city: "Eerie",
                              state: "Colorado",
                              zip_code: 80514,
                              reason: "hates dogs",
                              status: "Applied")
    visit "/applications/#{sam.id}"
    expect(page).to have_content(sam.applicant_name)
    expect(page).to have_content(sam.address)
    expect(page).to have_content(sam.city)
    expect(page).to have_content(sam.state)
    expect(page).to have_content(sam.zip_code)

    expect(page).to_not have_content(sam2.applicant_name)
  end
end

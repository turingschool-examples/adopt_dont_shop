require 'rails_helper'

RSpec.describe 'application show page' do
  it "shows the applicants attributes" do
    applicant = Applicant.create!(name: 'Andrew',
                              street_address: '112 Greenbrook',
                              city: 'Denver',
                              state: 'CO',
                              zipcode: '80207',
                              description: 'Happy, friendly, cool',
                              )
    application = applicant.applications.create!(pets: ['Dog','Cat'],
                                                 status: 'In Progress')
  end
end

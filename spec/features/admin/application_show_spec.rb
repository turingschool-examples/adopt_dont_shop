require 'rails_helper'

RSpec.describe 'admin application show' do
  let(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let(:application) { Application.create!(
                                    name: "Nate Brown",
                          street_address: "2000 35th Avenue",
                                    city: "Denver",
                                   state: "CO",
                                     zip: "90210",
                                  status: "In Progress",
                              description: "Big ol' backyard to run around in"

                                         )}
     describe 'the admin application show page' do
       it "has the applicant/'s attributes" do
         visit "admin/applicants/#{application.id}"

         expect(page).to have_content(application.name)
         expect(page).to have_content(application.full_address)
         expect(page).to have_content(application.description)
         expect(page).to have_content(application.status)
       end

       it "has working button for approving pets" do
         visit "admin/applicants/#{application.id}"


       end
     end
 end

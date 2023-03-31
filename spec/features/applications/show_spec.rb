require 'rails_helper'

RSpec.describe 'Application Show', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", address: '123 Cat St, Denver, CO 80238' , description:"I love animals so I want to adopt them", pet_names: "/pets/#{pet.id}", status: 'In Progress') }
  
end
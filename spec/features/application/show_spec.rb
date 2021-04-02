require 'rails_helper'

RSpec.describe "the Application show page" do
  it "should display applicant info" do
    pound = Shelter.create!(foster_program: true,
                            name: "da pound",
                            city: "Denver",
                            rank: 1,
                            created_at: Time.now,
                            updated_at: Time.now
                            )
      dog = pound.pets.create!(name: "Bob",
                              adoptable: true,
                              age: 1,
                              breed: "smol",
                              created_at: Time.now,
                              updated_at: Time.now
                              )
    # dog = Pet.create!(name: "Bob",
    #                   adoptable: true,
    #                   age: 1,
    #                   breed: "smol",
    #                   created_at: Time.now,
    #                   updated_at: Time.now)
    applicant = dog.applications.create!(name: "Fred",
                                    street_address: "123 way",
                                    city: "Denver",
                                    state: "Colorado",
                                    zip_code: 80204,
                                    description: "I like dogs",
                                    created_at: Time.now,
                                    updated_at: Time.now
                                    )
    # applicant = Application.create!(name: "Fred",
    #                           street_address: "123 way",
    #                           city: "Denver",
    #                           state: "Colorado",
    #                           zip_code: 80204,
    #                           description: "I like dogs",
    #                           created_at: Time.now,
    #                           updated_at: Time.now
    #                           )
    ApplicationPet.create!(application: applicant, pet: dog)

    visit '/welcome/show' #I am not sure where to visit for us1

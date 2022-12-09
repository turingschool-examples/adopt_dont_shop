require 'rails_helper'

RSpec.describe 'New Applications Page' do
  before(:each) do
    @aurora = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @rgv = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @fancy = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @stop_n_shop = Shelter.create(name: 'Stop And Shop', city: 'Portland, ME', foster_program: true, rank: 2)

    @pirate = @aurora.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @aurora.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @aurora.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @taco = @aurora.pets.create(name: 'Taco', breed: 'Chihuahua', age: 2, adoptable: true)
    @bell = @aurora.pets.create(name: 'Bell', breed: 'Chihuahua', age: 2, adoptable: true)
    @charlie = @aurora.pets.create(name: 'Charlie', breed: 'sphynx', age: 2, adoptable: true)

    @joe = @rgv.pets.create(name: 'Joe', breed: 'bulldog', age: 2, adoptable: true)
    @kaity = @rgv.pets.create(name: 'Kaity', breed: 'Siamese', age: 8, adoptable: true)
    @bo = @rgv.pets.create(name: 'Bo', breed: 'Borzoi', age: 4, adoptable: true)

    @coony = @fancy.pets.create(name: 'Coony', breed: 'Maine Coon', age: 10, adoptable: true)
    @bloom = @fancy.pets.create(name: 'Irishman', breed: 'irish wolfhound', age: 2, adoptable: true)
  end
  
  describe '2. Starting an Application' do
    describe "the pet index page has link to 'Start an Application'" do
      it 'takes the user to the new application page' do
        visit pets_path


      end
    end
    
    describe 'the new application page a form and a submit link, which sends the user to the application show page' do
      it 'requires the user to fill in all fields' do

      end

      it "sends the user to the new application's show page once the submit link is clicked" do

      end

      it "displays all the information the user completed and informs that this application 'in progress'" do
      end

    end
  end
end




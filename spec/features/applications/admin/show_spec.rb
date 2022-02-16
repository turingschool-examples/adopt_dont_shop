require 'rails_helper'

RSpec.describe Application, type: :feature do
  describe 'admin show page' do
    before :each do
      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      @pet_1 = shelter_1.pets.create!(name: 'Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = shelter_2.pets.create!(name: 'Gaspir', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = shelter_3.pets.create!(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)
      @pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

      @app_1 = Application.create!(
        name: "Jerry Blank",
        street_address: "246 DumDum Ave.",
        city: "Melbourne",
        state: "IL",
        zip_code: 53262,
        status: "Pending"
      )
      @app_2 = Application.create!(
        name: "Jeff Jippers",
        street_address: "123 Affirmative Ave.",
        city: "Claytown",
        state: "AL",
        zip_code: 34567,
        status: "Pending"
      )
      PetApplication.create!(pet_id: @pet_3.id, application_id: @app_2.id)
      PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id)
      PetApplication.create!(pet_id: @pet_2.id, application_id: @app_1.id)

    end

    it 'lists application details including pets applied for' do
      visit "/admin/applications/#{@app_1.id}"

      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_1.street_address)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zip_code)

      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_3.name)
      expect(page).to_not have_content(@pet_4.name)

    end

    describe 'approving and rejecting' do
      it 'approves pet applications - single case' do
        visit "/admin/applications/#{@app_2.id}"

        expect(page).to have_content("#{@pet_3.name}")
        click_button("Approve")

        expect(current_path).to eq("/admin/applications/#{@app_2.id}")

        expect(page).to have_content("#{@pet_3.name} - APPROVED")

        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
      end

      it 'approves multiple pet applications' do
        visit "/admin/applications/#{@app_1.id}"

        within("#decide-#{@pet_1.id}") do
          click_button("Approve")
        end

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")

        within("#decide-#{@pet_1.id}") do
          expect(page).to have_content("#{@pet_1.name} - APPROVED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end

        within("#decide-#{@pet_2.id}") do
          expect(page).to have_content("#{@pet_2.name}")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")

          click_button("Approve")
        end

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")

        within("#decide-#{@pet_1.id}") do
          expect(page).to have_content("#{@pet_1.name} - APPROVED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end

        within("#decide-#{@pet_2.id}") do
          expect(page).to have_content("#{@pet_2.name} - APPROVED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end
      end

      it 'rejects pet applications - single case' do
        visit "/admin/applications/#{@app_2.id}"

        expect(page).to have_content("#{@pet_3.name}")
        click_button("Reject")

        expect(current_path).to eq("/admin/applications/#{@app_2.id}")

        expect(page).to have_content("#{@pet_3.name} - REJECTED")

        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
      end

      it 'rejects multiple pet applications' do
        visit "/admin/applications/#{@app_1.id}"

        within("#decide-#{@pet_1.id}") do
          click_button("Reject")
        end

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")

        within("#decide-#{@pet_1.id}") do
          expect(page).to have_content("#{@pet_1.name} - REJECTED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end

        within("#decide-#{@pet_2.id}") do
          expect(page).to have_content("#{@pet_2.name}")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")

          click_button("Reject")
        end

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")

        within("#decide-#{@pet_1.id}") do
          expect(page).to have_content("#{@pet_1.name} - REJECTED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end

        within("#decide-#{@pet_2.id}") do
          expect(page).to have_content("#{@pet_2.name} - REJECTED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end
      end

      it 'approves and rejects pets on the same application' do
        visit "/admin/applications/#{@app_1.id}"

        within("#decide-#{@pet_1.id}") do
          click_button("Reject")
        end

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")

        within("#decide-#{@pet_1.id}") do
          expect(page).to have_content("#{@pet_1.name} - REJECTED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end

        within("#decide-#{@pet_2.id}") do
          expect(page).to have_content("#{@pet_2.name}")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")

          click_button("Approve")
        end

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")

        within("#decide-#{@pet_1.id}") do
          expect(page).to have_content("#{@pet_1.name} - REJECTED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end

        within("#decide-#{@pet_2.id}") do
          expect(page).to have_content("#{@pet_2.name} - APPROVED")
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
        end
      end


      it 'approval or rejection on one application does not impact another' do
        PetApplication.create!(pet_id: @pet_1.id, application_id: @app_2.id)
        PetApplication.create!(pet_id: @pet_2.id, application_id: @app_2.id)

        visit "/admin/applications/#{@app_1.id}"

        within("#decide-#{@pet_1.id}") do
          click_button("Reject")
        end
        within("#decide-#{@pet_2.id}") do
          click_button("Approve")
        end

        visit "/admin/applications/#{@app_2.id}"

        within("#decide-#{@pet_1.id}") do
          expect(page).to_not have_content("#{@pet_1.name} - APPROVED")
          expect(page).to_not have_content("#{@pet_1.name} - REJECTED")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end

        within("#decide-#{@pet_2.id}") do
          expect(page).to_not have_content("#{@pet_2.name} - APPROVED")
          expect(page).to_not have_content("#{@pet_2.name} - REJECTED")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end
      end

      describe 'completed applications' do
        it 'single-pet approval' do
          visit "/admin/applications/#{@app_2.id}"
          expect(page).to have_content("Application Status: Pending")

          within("#decide-#{@pet_3.id}") do
            click_button("Approve")
          end

          expect(current_path).to eq("/admin/applications/#{@app_2.id}")
          expect(page).to have_content("Application Status: Approved")
        end

        it 'single-pet rejection' do
          visit "/admin/applications/#{@app_2.id}"
          expect(page).to have_content("Application Status: Pending")

          within("#decide-#{@pet_3.id}") do
            click_button("Reject")
          end

          expect(current_path).to eq("/admin/applications/#{@app_2.id}")
          expect(page).to have_content("Application Status: Rejected")
        end

        it 'remains open until all pets are rejected or approved for the application' do
          visit "/admin/applications/#{@app_1.id}"

          expect(page).to have_content("Application Status: Pending")

          within("#decide-#{@pet_1.id}") do
            click_button("Approve")
          end

          within("#decide-#{@pet_2.id}") do
            expect(page).to have_button("Approve")
            expect(page).to have_button("Reject")
          end
          expect(page).to have_content("Application Status: Pending")
        end

        it 'approve application when all pets are approved' do
          visit "/admin/applications/#{@app_1.id}"
          expect(page).to have_content("Application Status: Pending")

          within("#decide-#{@pet_1.id}") do
            click_button("Approve")
          end

          within("#decide-#{@pet_2.id}") do
            click_button("Approve")
          end

          expect(page).to have_content("Application Status: Approved")
        end

        it 'rejects application when any pets are rejected' do
          visit "/admin/applications/#{@app_1.id}"
          expect(page).to have_content("Application Status: Pending")

          within("#decide-#{@pet_1.id}") do
            click_button("Approve")
          end

          within("#decide-#{@pet_2.id}") do
            click_button("Reject")
          end

          expect(page).to have_content("Application Status: Rejected")
        end

        it 'pets on approved applications are no longer adoptable' do
          visit "/pets"

          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_2.name)
          expect(page).to have_content(@pet_3.name)
          expect(page).to have_content(@pet_4.name)

          visit "/admin/applications/#{@app_2.id}"

          within("#decide-#{@pet_3.id}") do
            click_button("Approve")
          end

          expect(current_path).to eq("/admin/applications/#{@app_2.id}")
          expect(page).to have_content("Application Status: Approved")

          visit "/pets/#{@pet_3.id}"
          expect(page).to have_content("Adoptable: false")

          visit "/pets"

          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_2.name)
          expect(page).to_not have_content(@pet_3.name)
          expect(page).to have_content(@pet_4.name)
        end

        it 'pets on rejected applications remain adoptable' do
          visit "/pets"

          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_2.name)
          expect(page).to have_content(@pet_3.name)
          expect(page).to have_content(@pet_4.name)

          visit "/admin/applications/#{@app_2.id}"

          within("#decide-#{@pet_3.id}") do
            click_button("Reject")
          end

          expect(current_path).to eq("/admin/applications/#{@app_2.id}")
          expect(page).to have_content("Application Status: Rejected")

          visit "/pets/#{@pet_3.id}"
          expect(page).to have_content("Adoptable: true")
          
          visit "/pets"

          expect(page).to have_content(@pet_1.name)
          expect(page).to have_content(@pet_2.name)
          expect(page).to have_content(@pet_3.name)
          expect(page).to have_content(@pet_4.name)
        end
      end
    end
  end
end

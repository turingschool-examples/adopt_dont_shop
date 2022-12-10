
application = FactoryBot.create(:application)
shelter_1   = FactoryBot.create(:shelter)
vet_office   = FactoryBot.create(:veterinary_office)
vet_1        = FactoryBot.create(:veterinarian, veterinary_office: vet_office)
vet_2        = FactoryBot.create(:veterinarian, veterinary_office: vet_office)
pet_1       = FactoryBot.create(:pet, shelter: shelter_1)
pet_2       = FactoryBot.create(:pet, shelter: shelter_1)
pet_3       = FactoryBot.create(:pet, shelter: shelter_1)

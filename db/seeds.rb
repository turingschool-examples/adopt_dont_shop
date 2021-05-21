3.times do
  shelter = FactoryBot.create(:shelter)

  rand(5..10).times do
    FactoryBot.create(:pet, shelter: shelter)
  end
end

3.times do
  veterinary_office = FactoryBot.create(:veterinary_office)

  rand(5..10).times do
    FactoryBot.create(:veterinarian, veterinary_office: veterinary_office)
  end
end

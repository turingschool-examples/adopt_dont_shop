PetApp.destroy_all
Pet.destroy_all
Shelter.destroy_all
App.destroy_all


shelter1 =Shelter.create!(name:'Detroit Human People', city:'Detroit', foster_program:true, rank: 6)
shelter2 =Shelter.create!(name:'Another Shelter', city:'Las Angeles', foster_program:true, rank: 7)
shelter3 =Shelter.create!(name:'a shelter', city:'Denver', foster_program:false, rank: 3)
shelter6=Shelter.create!(name:'Marquette Humane Society', city:'Marquette', foster_program:true, rank: 1)
shelter7=Shelter.create!(name:'San Antonio Humane Society', city:'San Antonio', foster_program:true, rank: 2)
@app = App.create(name: 'Scooby', street: "123", city:"fake", state: "fake", zip: 48248)
@pet_1 = Pet.create(name:'Muffin',adoptable:true,breed:'fluffy cat',age:5, shelter_id:shelter6.id, pic:'20210429_144443.jpg')
Pet.create(name:'Tesla',adoptable:true,breed:'hunter cat',age:4, shelter_id:shelter7.id, pic:'tesla.jpg')
Pet.create(name:'Cosmos',adoptable:true,breed:'playful cat',age:4, shelter_id:shelter7.id, pic:'20210429_144443.jpg')

Pet.create!(name:'The Doge',adoptable:true,breed:'moon pup',age:7, shelter_id:shelter1.id, pic:'doge.jpeg')
Pet.create!(name:'Lola',adoptable:true,breed:'angry cat',age:3, shelter_id:shelter2.id, pic:'yellcat.png')
Pet.create!(name:'Piper',adoptable:true,breed:'another puppy',age:4, shelter_id:shelter3.id, pic:'dogie.jpeg')
Pet.create!(name:'Grump Cat',adoptable:true,breed:'another puppy',age:5, shelter_id:shelter6.id, pic:'grump.jpeg')

#@pet_app = @pet_1.pet_apps.create(app_id: @app.id)


PetApplicant.delete_all
Pet.delete_all  
Shelter.delete_all
Applicant.delete_all
##SHELTERS
    @aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @mystery_bldg = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @boulder = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    
    @rgv = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @fancy_colordo = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

 ##PETS   
    
    @mr_pirate = @aurora.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @aurora.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @ann = @aurora.pets.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

    @lucille_bald = @mystery_bldg.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @lobster = @mystery_bldg.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
    @scooby = @mystery_bldg.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    
    @sylvester = @boulder.pets.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester')
    @lasagna = @boulder.pets.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna')
    
## APPLICANTS    
    @heather = Applicant.create!(name: "Heather Moore", street: "Pearl St", city: "Denver", state: "CO", zip: "80210", good_home: "live close to dog parks")
    @olivia = Applicant.create!(name: "Olivia Valentin", street: "1234 Main St", city: "Denver", state: "CO", zip: "80203", good_home: "I have vetenarian expierence")
    
    PetApplicant.create!(applicant: @olivia, pet: @lucille_bald)
    PetApplicant.create!(applicant: @olivia, pet: @lobster)
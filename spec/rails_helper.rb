require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
end

require './spec/fixtures/veterinary_office_data'
require './spec/fixtures/veterinarian_data'
require './spec/fixtures/application_data'
require './spec/fixtures/pet_data'
require './spec/fixtures/shelter_data'

include VeterinaryOfficeData
include VeterinarianData
include ApplicationData
include PetData
include ShelterData

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.before(:each) do
    VeterinaryOffice.destroy_all
    Veterinarian.destroy_all

    @vet_office_1 = VeterinaryOffice.create!(OFFICE_1)
    @vet_office_2 = VeterinaryOffice.create!(OFFICE_2)
    @vet_office_3 = VeterinaryOffice.create!(OFFICE_3)

    @vet_1 = @vet_office_1.veterinarians.create!(VET_1)
    @vet_2 = @vet_office_2.veterinarians.create!(VET_2)
    @vet_3 = @vet_office_3.veterinarians.create!(VET_3)

    
    @shelter_1 = Shelter.create!(SHELTER_1)
    @shelter_2 = Shelter.create!(SHELTER_2)
    @shelter_3 = Shelter.create!(SHELTER_3)
    
    @pet_1 = @shelter_1.pets.create!(PET_1)
    @pet_2 = @shelter_1.pets.create!(PET_2)
    @pet_3 = @shelter_1.pets.create!(PET_3)
    @pet_4 = @shelter_1.pets.create!(PET_4)
    @pet_5 = @shelter_2.pets.create!(PET_5)
    @pet_6 = @shelter_2.pets.create!(PET_6)
    @pet_7 = @shelter_3.pets.create!(PET_7)
    @pet_8 = @shelter_3.pets.create!(PET_8)
    @pet_9 = @shelter_3.pets.create!(PET_9)
    @pet_10 = @shelter_3.pets.create!(PET_10)

    @app_1 = Application.create!(APP_1)
    @app_2 = Application.create!(APP_2)
    @app_3 = Application.create!(APP_3)
    @app_4 = Application.create!(APP_4)

    PetApplication.create!(application_id: @app_2.id, pet_id: @pet_2.id)
    PetApplication.create!(application_id: @app_2.id, pet_id: @pet_3.id)
    PetApplication.create!(application_id: @app_2.id, pet_id: @pet_1.id)
    PetApplication.create!(application_id: @app_2.id, pet_id: @pet_4.id)
    PetApplication.create!(application_id: @app_3.id, pet_id: @pet_7.id)
    PetApplication.create!(application_id: @app_3.id, pet_id: @pet_8.id)
    PetApplication.create!(application_id: @app_3.id, pet_id: @pet_1.id)
    PetApplication.create!(application_id: @app_3.id, pet_id: @pet_2.id)
    PetApplication.create!(application_id: @app_4.id, pet_id: @pet_9.id)
    PetApplication.create!(application_id: @app_4.id, pet_id: @pet_10.id)
    PetApplication.create!(application_id: @app_4.id, pet_id: @pet_7.id)
    PetApplication.create!(application_id: @app_4.id, pet_id: @pet_8.id)
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
     with.test_framework :rspec
     with.library :rails
  end
end
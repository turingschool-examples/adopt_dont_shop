class PetApplication < ApplicationRecord

belongs_to :pet
belongs_to :application_form

# validates_uniqueness_of :pet_id, :scope => :application_form_id
end

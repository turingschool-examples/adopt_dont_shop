class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  #validates :pet_id, uniqueness: { scope: :application_id }

  def self.find_by_rels(pet_id, application_id)
    where("pet_id = #{pet_id} and application_id = #{application_id}").first
  end

end

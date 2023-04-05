class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def pet_app(app)
    PetApplication.where("pet_id = #{self.id} and application_id = #{app.id}").first
  end

  def has_accepted_application(app)
    applications.where('status = 2 and applications.id != ?', app.id).present?
  end
end

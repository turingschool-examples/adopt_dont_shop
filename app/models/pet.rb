class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_apps
  has_many :apps, through: :pet_apps

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def not_adoptable
    update(adoptable: false)
  end

  def already_accepted?
    apps.any? { |app| app.status == 'accepted' }
  end

  def pet_app_approval(app)
    # require 'pry'; binding.pry
    pet_apps.find_by(app_id: app.id).approval
  end
end

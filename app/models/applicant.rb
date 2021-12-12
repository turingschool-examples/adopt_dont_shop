class Applicant < ApplicationRecord
  has_many :pet_applicants
  has_many :pets, through: :pet_applicants

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, numericality: true

  def update_status
    if self.description == nil || self.pets.empty?
      self.update({status: 'In Progress'})
      self.save
    elsif self.description != nil && !self.pets.empty?
      self.update({status: 'Pending'})
      self.save
    end
  end

end

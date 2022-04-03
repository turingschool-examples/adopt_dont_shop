class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  delegate :name, to: :shelter, prefix: true

  def self.adoptable
    where(adoptable: true)
  end
end

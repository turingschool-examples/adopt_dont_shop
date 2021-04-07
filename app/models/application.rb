class Application < ApplicationRecord
  validates :status, presence: true
  validates :user_id, presence: true, numericality: true

  has_many :applications_pets, dependent: :destroy
  has_many :pets, through: :applications_pets, dependent: :destroy

  belongs_to :user

  def pets_empty?
    pets.empty?
  end

  def user_name
    user.full_name
  end
end

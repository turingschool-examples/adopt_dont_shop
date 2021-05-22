# frozen_string_literal: true

class VeterinaryOffice < ApplicationRecord
  validates :name, presence: true
  validates :max_patient_capacity, presence: true, numericality: true

  has_many :veterinarians, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_vets
    select('veterinary_offices.*, count(veterinarians.id) AS vets_count')
      .joins('LEFT OUTER JOIN veterinarians ON veterinarians.veterinary_office_id = veterinary_offices.id')
      .group('veterinary_offices.id')
      .order('vets_count DESC')
  end

  def vet_count
    veterinarians.count
  end

  def on_call_vets
    veterinarians.where(on_call: true)
  end

  def alphabetical_vets
    on_call_vets.order(name: :asc)
  end

  def office_vets_filtered_by_rating(rating_filter)
    on_call_vets.where('review_rating >= ?', rating_filter)
  end
end

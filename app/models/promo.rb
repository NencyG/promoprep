# frozen_string_literal: true

# Promo modal
class Promo < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date , presence: true
  validates :description, presence: true, length: { minimum: 5 }
end

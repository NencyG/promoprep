# frozen_string_literal: true

# Promo modal
class Promo < ApplicationRecord
  belongs_to :company
  has_many :promo_filter_options, dependent: :destroy
  has_many :filter_options, through: :promo_filter_options
  validates_presence_of :name
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates :description, presence: true, length: { minimum: 5 }
  validates_presence_of :promo_filter_options
  default_scope { order(created_at: :desc) }
end

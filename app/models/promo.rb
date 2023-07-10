# frozen_string_literal: true

# Promo modal
class Promo < ApplicationRecord
  belongs_to :company
  has_many :promo_filter_options, dependent: :destroy
  has_many :filter_options, through: :promo_filter_options
  validates_presence_of :name, :start_date, :end_date, :promo_filter_options
  validates :description, presence: true, length: { minimum: 5 }
  default_scope { order(created_at: :desc) }

  require 'csv'
  def self.to_csv
    attributes = %w[id name start_date end_date description company_id]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |promo|
        csv << attributes.map { |attr| promo.send(attr) }
      end
    end
  end
end

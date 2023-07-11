# frozen_string_literal: true

# Promo modal
class Promo < ApplicationRecord
  belongs_to :company
  has_many :promo_filter_options, dependent: :destroy
  has_many :filter_options, through: :promo_filter_options
  validates :name, presence: true
  validates :start_date, presence: true, format: { with: /^\d{4}-\d{2}-\d{2}$/, multiline: true }
  validates :end_date, presence: true, format: { with: /^\d{4}-\d{2}-\d{2}$/, multiline: true }
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

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Promo.create! row.to_hash
    end
  end
end

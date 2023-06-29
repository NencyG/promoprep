class FilterOption < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  has_many :promo_filter_options, dependent: :destroy
end

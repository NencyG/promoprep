class FilterOption < ApplicationRecord
  belongs_to :company
  has_many :promo_filter_options, dependent: :destroy
  validates :name, presence: true
end

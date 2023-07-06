class PromoFilterOption < ApplicationRecord
  belongs_to :promo
  belongs_to :filter_option
  validates :filter_option_id, presence: true
end

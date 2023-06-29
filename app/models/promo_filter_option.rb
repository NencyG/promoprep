class PromoFilterOption < ApplicationRecord
  belongs_to :promo
  belongs_to :filter_options
end

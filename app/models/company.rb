# frozen_string_literal: true

# company modal
class Company < ApplicationRecord
  belongs_to :user
  has_many :filter_options, class_name: 'FilterOption', dependent: :destroy, inverse_of: :company
  accepts_nested_attributes_for :filter_options, allow_destroy: true, reject_if: :all_blank
  has_many :promos, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i }
end

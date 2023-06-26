# frozen_string_literal: true

# company modal
class Company < ApplicationRecord
  belongs_to :user
  has_many :promos, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}
end

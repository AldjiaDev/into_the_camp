class Product < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_many :reviews

  validates :name, :description, :price_per_day, :location, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
end

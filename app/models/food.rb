class Food < ApplicationRecord
  has_many :inventory_foods
  has_many :inventories, through: :inventory_foods

  attribute :name, :string
  attribute :measurement_unit, :string
  attribute :price, :decimal

  validates :name, presence: true, uniqueness: true
  validates :measurement_unit, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end

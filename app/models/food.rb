class Food < ApplicationRecord
  has_many :inventory_foods
  has_many :inventories, through: :inventory_foods
end

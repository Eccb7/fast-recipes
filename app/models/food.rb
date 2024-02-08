class Food < ApplicationRecord
  belongs_to :user
  
  has_many :inventory_foods, foreign_key: 'food_id'
  has_many :inventories, through: :inventory_foods

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, length: { maximum: 250 }
  validates :measurement_unit, presence: true
  validates :quantity, presence: true

 def self.inventories_totals
  joins(
    "INNER JOIN (
       SELECT food_id,
              SUM(quantity) as total_quantity,
              SUM(value) as total_value
       FROM inventory_foods
       GROUP BY food_id
     ) AS subquery ON foods.id = subquery.food_id"
  ).select('foods.name, subquery.total_quantity, subquery.total_value')
end
end
end

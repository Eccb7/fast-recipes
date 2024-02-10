class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :quantity, presence: true
  validates :food_id, presence: true

  attribute :food_name, :string
  attribute :food_price, :decimal
  attribute :quantity, :integer

  attr_accessor :food_name, :food_price, :quantity

  def self.permitted_attributes
    %i[food_id quantity price]
  end
end

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :recipe_name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :public, inclusion: { in: [true, false] }

  validates :user_id, presence: true

  def user_exists
    errors.add(:user, 'must exist') unless user.present?
  end

  def load_recipe_foods
    recipe_foods.reload
  end
end

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :recipe_name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :public, inclusion: { in: [true, false] }

  validate :user_exists

  def user_exists
    errors.add(:user_id, 'must exist') unless User.exists?(user_id)
  end

  def load_recipe_foods
    recipe_foods.reload
  end
end

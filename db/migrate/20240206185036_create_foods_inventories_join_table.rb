class CreateFoodsInventoriesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :foods, :inventories do |t|
      t.index :inventory_id
      t.index :food_id
    end
  end
end

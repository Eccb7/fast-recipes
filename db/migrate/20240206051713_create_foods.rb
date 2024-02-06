class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.text :name
      t.integer :measurement_unit
      t.float :price

      t.timestamps
    end
  end
end

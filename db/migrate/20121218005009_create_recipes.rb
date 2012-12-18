class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :result_id
      t.integer :component_id

      t.timestamps
    end
    add_index :recipes, :result_id
    add_index :recipes, :component_id
  end
end

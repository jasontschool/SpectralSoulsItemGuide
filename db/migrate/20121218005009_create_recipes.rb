class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :result
      t.string :component

      t.timestamps
    end
    add_index :recipes, :result
    add_index :recipes, :component
  end
end

class RenameRecipesFields < ActiveRecord::Migration
  def change
    change_column(:recipes, :result, :integer)
    rename_column(:recipes, :result, :result_id)
    change_column(:recipes, :component, :integer)
    rename_column(:recipes, :component, :component_id)
  end
end

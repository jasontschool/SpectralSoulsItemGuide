class RenameRecipesFields < ActiveRecord::Migration
  def change
    #this change had to be done retroactively to create_recipes
    #due to heroku error with postgres (cannot cast column to integer)
    #boo :(
  end
end

class Recipe < ActiveRecord::Base
  #associations not a primary concern of this project
  #add in future for code quality?
  def result
    Item.find_by_id(result_id)
  end
  def component
    Item.find_by_id(component_id)
  end
end

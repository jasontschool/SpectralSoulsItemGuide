class Recipe < ActiveRecord::Base
  def result
    Item.find_by_id(result_id)
  end
  def component
    Item.find_by_id(component_id)
  end
end

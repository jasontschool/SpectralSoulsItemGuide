class InventEquip < ActiveRecord::Base
  #Similar reasoning here as in Recipes (with associations)
  def base
    Item.find_by_id(base_id)
  end
  def result
    Item.find_by_id(result_id)
  end

end

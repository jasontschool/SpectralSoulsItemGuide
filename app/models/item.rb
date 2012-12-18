class Item < ActiveRecord::Base
  #The goal of this project is more UI/front-end based, so I'm 
  #not fully utilizing associations at the moment.
  def components
    Recipe.find_all_by_result_id(id).map {|x| Item.find_by_id(x.component_id)}
  end
  def synthesizes
    Recipe.find_all_by_component_id(id).map {|x| Item.find_by_id(x.result_id)}
  end
  
  def equippable?
    #accurate, but slower:
    #Equipment.exists?(:name=>name)
    
    #less accurate, faster 
    #(depends on all equipment existing, and fixed name for non-equippables)
    item_type != Item.non_item_name
  end
  
  def self.non_item_name
    return "Synthesis component"
  end
end

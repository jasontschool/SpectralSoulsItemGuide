class Item < ActiveRecord::Base
  #The goal of this project is more UI/front-end based, so I'm 
  #not fully utilizing associations at the moment.
  def components
    Recipe.find_all_by_result_id(id).map {|x| x.component}
  end
  
  def synthesizes
    Recipe.find_all_by_component_id(id).map {|x| x.result}.uniq
  end
  
  def invents
    InventEquip.find_all_by_base_id(id).map{|x| x.result}
  end
  
  def invents_from
    return InventEquip.find_all_by_result_id(self.id).map{|x| x.base}
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

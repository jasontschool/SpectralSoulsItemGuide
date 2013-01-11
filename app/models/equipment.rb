class Equipment < ActiveRecord::Base

  def get_item #corresponding item record
    Item.find_by_name(name)
  end
      
  def basic_stats
      return {:type => item_type,
              :element => element,
              :register? => register,
              :buy => (buy==0)? "Not purchasable" : "#{buy} G",
              :sell => "#{sell} G"
              }
  end
  def spec_stats
    if weapon?
      return {:range => range,
              :height => height,
              :"weapon slot 1" => weapon1,
              :"weapon slot 2" => weapon2,
              :"weapon slot 3" => weapon3,
              :"weapon slot 4" => weapon4,
              }
    else
      return {:"absorbs element" => absorb,
              :autoskill => autoskill,
              :"autoskill slots" => autoskill_slot_count}
    end
  end
  
  def eqp_stats
    return collect_stats([:atk, :def, :hit, :avd, :mag])
  end
  
  def char_stats
    return collect_stats([:str, :vit, :agl, :int, :luk])
  end
  
  def misc_stats
    return collect_stats([:ap, :cost])
  end
  
  def collect_stats(stats)
    #Since cost at level 1 is not defined, put a temporary variable
    cost1 = "-"
    return Hash[stats.collect {|field| [field, (1..5).map {|n| eval("#{field}#{n}")}]}]
  end
  
  def invents_into
    get_item.invents
  end
  
  def invents_from
    get_item.invents_from
  end
  
  def weapon?
    ["Sword", "Great Sword", "Shortsword", "Spear", "Staff", "Knuckle", "Breaker", "Gun", "Scythe"].include?(item_type)
  end
  
  def non_weapon?
    ["Armour", "Ring"].include?(item_type)
  end    
  
end

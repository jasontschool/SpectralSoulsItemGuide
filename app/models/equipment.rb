class Equipment < ActiveRecord::Base

  def basic_stats
      return {:type => item_type,
              :element => element,
              :register? => register,
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
  
  def collect_stats(stats)
    return Hash[stats.collect {|field| [field, (1..5).map {|n| eval("#{field}#{n}")}]}]
  end
  
  def invents_into
    temp = [invent1, invent2]
    #temp.delete_at(1) if temp[1]=="(nothing)"
    temp.delete("(nothing)")
    return temp
  end
  
  def weapon?
    !non_weapon?
  end
  
  def non_weapon?
    ["Armour", "Ring"].include?(item_type)
  end    
  
end

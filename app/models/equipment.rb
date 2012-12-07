class Equipment < ActiveRecord::Base
=begin
    #These are rather optional, validations aren't truly necessary since the data
    #only comes from one source and can never be created otherwise.

    validates_presence_of :name, :item_type, :element, :register, 
                            :sell, :buy, :invent1, :invent2
    validate :weapon_fields_present, :if=>:weapon?
    validate :non_weapon_fields_present, :if=>:non_weapon?
=end
    
    def weapon?
        item_type == "weapon"
    end
    
    def non_weapon?
        !weapon?
    end
    
=begin
#These are rather optional, validations aren't truly necessary since the data
#only comes from one source and can never be created otherwise.
    #TODO: CONVERT TO NIL VALUES WHERE NEED IN ITEMSEARCH, MAKE CHECKS HERE.
    def weapon_fields_present
        not_nil = ["range", "height"]
        (1..4).each do |x|
            not_nil << "weapon#{x}"
            conditional_nil << "weapon#{x}_level"
        end
        check_presence not_nil
    end
    
    def non_weapon_fields_present
        not_nil = ["absorb", "autoskill", "autoskill_slot_count"]
        check_presence not_nil
    end
    
    def check_presence(not_nil)
        not_nil.each do |x|
            if self.send(x).nil?
                errors.add(x, "must be present")
            end
        end
    end
=end
end

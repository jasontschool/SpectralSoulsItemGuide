#TEST FILES
#SS-specific check.
def check_accurate(results_hash, files_hash)
    accurate = true
    result_names_hash = results_hash.each_with_object({}) do |(k, v), h|
        h[k] = v.map {|x| x["name"]}
    end
    ss_item_presence = /\d\.(\d| )\d\. ([^\n]+)\n\nType/
    files_hash.each do |k, v|
        names = v.scan(ss_item_presence).map {|x| x[1]}
        result_names = result_names_hash[k]
        results = results_hash[k]
        puts "#{result_names.count}/#{names.size} items found in #{k}!"
        if result_names.count < names.size
            (names - result_names).each {|name| puts "Missing #{name} from #{k}"}
            accurate = false
        end
        results.each do |item_hash|
            if not validate_object(item_hash)
                accurate = false
                break
            end
        end
        
        
        break unless accurate
    end
    #results_hash[:test].each do |i| p i end
    
    puts accurate ? "Tests passed!" : "Tests failed!"
    return accurate
end

#Doesn't check unique object specifics, only mandatory object presence.
#TODO: ring/armor debug.
def validate_object(item_hash)
    not_nil = ["name", "type", "element", "register", "sell", "buy", "invent1", "invent2"]
    stats = ["atk", "def", "hit", "avd", "mag", "str", "vit", "agl", "int", "luk", "cost", "ap"]
    stats.each do |stat|
        not_nil += (1..5).map {|x| "#{stat}#{x}"}
    end
    not_nil.delete("cost1") #no cost for level 1.
        
    conditional_nil = []
    valid = true
    case item_hash["type"]
    when "Armour", "Ring"
        not_nil += ["absorb", "autoskill", "autoskill_slot_count"]
    else
        not_nil += ["range", "height"]
        (1..4).each do |x|
            not_nil << "weapon#{x}"
            conditional_nil << "weapon#{x}_level"
        end
    end
    
    
    not_nil.each do |x|
        if item_hash[x].nil?
            valid = false
            puts "Couldn't find #{x} in  #{item_hash}"
        end
    end
    conditional_nil.each do |x|
        if match = (/([\w ]+)_level/.match(x)[1])
            if item_hash[match] != "(nothing)" and item_hash[x].nil?
                valid = false 
                "Couldn't find #{x} in #{item_hash}, but expected it"
            end    
        end
    end
    return valid
end
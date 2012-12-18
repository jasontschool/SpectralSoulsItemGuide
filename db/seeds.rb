# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Notes: keys in the hashes here can be referenced in SSItemSearch.rb
require_relative "SSItemSearch"
results = prepare_seed()

#Destroy all table entries so far to maintain integrity.
#This is to maintain exactly the right number of created recipe records
#eg for recipes that are made of 4x same item (eg Speed Ring)
Recipe.delete_all
Item.delete_all
Equipment.delete_all

progress = 0
interval = 25
results[:equip].each do |item_hash| 
    progress+=1
    if progress % interval == 0
      puts "Adding #{item_hash["name"]} equipment (number #{progress})"
    end
    equip = Equipment.find_or_create_by_name(item_hash["name"], item_hash)
    Item.find_or_create_by_name(item_hash["name"], 
          {:name => item_hash["name"], :item_type => item_hash["item_type"]})
end

puts "Completed equipment creation!"

def create_item_with_equip(name)
  if (item = Item.find_by_name(name)).nil?
      item_type = Item.non_item_name
      if (temp = Equipment.find_by_name(name))
        item_type = temp.item_type
      end
      item = Item.create(:name=> name, :item_type => item_type)
  end
  return item
end

progress = 0

results[:synth].each do |item_hash|
    progress+=1
    if progress % interval == 0
      puts "Adding #{item_hash["name"]} synthesis (number #{progress})"
    end
    res_name = item_hash["name"]
    res = create_item_with_equip(res_name)
    item_hash["components"].each do |comp_name|
      comp = create_item_with_equip(comp_name)
      Recipe.create(:result_id=>res.id, :component_id=>comp.id)
    end
end

puts "Completed synthesis creation!"
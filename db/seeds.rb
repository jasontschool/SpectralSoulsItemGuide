# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Notes: keys in the hashes here can be referenced in SSItemSearch.rb
require_relative "SSItemSearch"
results = prepare_seed()

results[:equip].each do |item_hash| 
    equip = Equipment.find_or_create_by_name(item_hash["name"], item_hash)
end

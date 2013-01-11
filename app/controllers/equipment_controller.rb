class EquipmentController < ApplicationController
    #equipment = plural, equip = single.
  def index
    @equipment = silent("Equipment.all")
    @item_types = silent("Equipment.uniq.pluck :item_type")
  end
  
  def show
    @equip = Equipment.find_by_name(params[:name])
    if @equip.nil?
    else
      @general = @equip.basic_stats.map
      @invents = @equip.invents_into.map {|x| x.name}
      @invents_from = @equip.invents_from.map {|x| x.name}
      @specs = @equip.spec_stats 
      @eqp_stats = @equip.eqp_stats
      @char_stats = @equip.char_stats
      @misc_stats = @equip.misc_stats
      
      temp = Item.find_by_name @equip.name
      @synthesizes = temp.synthesizes.map{|x| check_equip x}
      @components = temp.components.map{|x| check_equip x}
    end
  end
end

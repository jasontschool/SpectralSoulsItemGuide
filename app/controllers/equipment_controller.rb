class EquipmentController < ApplicationController
    #equipment = plural, equip = single.
  def index
    @equipment = silent("Equipment.all")
    @item_types = silent("Equipment.uniq.pluck :item_type")
  end
  
  def show
    @equip = silent("Equipment.find_by_name(params[:name])")
    if @equip.nil?
    else
      @general = @equip.basic_stats.map
      @invents = @equip.invents_into
      @specs = @equip.spec_stats 
      @eqp_stats = @equip.eqp_stats
      @char_stats = @equip.char_stats
    end
  end
end

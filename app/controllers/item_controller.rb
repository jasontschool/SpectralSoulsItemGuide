class ItemController < ApplicationController
  def index
    @items = silent("Item.order(:name)")
    
  end

  def show
    name = params[:name]
    @item = Item.find_by_name name
    @synthesizes = @item.synthesizes.map {|x| check_equip x}
    @components = @item.components.map{|x| check_equip x}
  end
end

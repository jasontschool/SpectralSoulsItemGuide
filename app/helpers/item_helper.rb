module ItemHelper

  def show_best_path(item)
    if item.equippable?
      return show_equipment_path(item.name)
    else
      return show_item_path(item.name)
    end
  end
end

class EquipmentController < ApplicationController
    #equipment = plural, equip = single.
    def index
        @equipment = silent("Equipment.all")
    end
end

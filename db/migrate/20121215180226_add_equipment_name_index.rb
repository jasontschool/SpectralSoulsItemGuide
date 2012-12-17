class AddEquipmentNameIndex < ActiveRecord::Migration
  def change
    add_index :equipment, :name
  end
end

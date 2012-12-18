class DeleteInventColumnsFromEquipment < ActiveRecord::Migration
  def change
    remove_column :equipment, :invent1
    remove_column :equipment, :invent2
  end
end

class CreateInventEquips < ActiveRecord::Migration
  def change
    create_table :invent_equips do |t|
      t.integer :base_id
      t.integer :result_id
      t.timestamps
    end
    add_index :invent_equips, :result_id
    add_index :invent_equips, :base_id
  end
  
end

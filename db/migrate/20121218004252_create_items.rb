class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :item_type

      t.timestamps
    end
    add_index :items, :name
  end
end

class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
        t.string    :name
        t.string    :item_type
        t.boolean   :unique_user
        t.integer   :range
        t.integer   :range_unique_code
        t.integer   :height
        t.string    :element
        t.string    :absorb
        t.string    :register
        t.integer   :sell
        t.integer   :buy
        t.string    :invent1
        t.string    :invent2
        (1..4).each do |num|
            t.string    :"weapon#{num}"
            t.integer   :"weapon#{num}_level"
        end
        t.string    :autoskill
        t.integer   :autoskill_slot_count
        [:atk, :def, :hit, :avd, :mag, :str, :vit, :agl, :int, :luk, :cost, :ap].each do |stat|
            t.integer   :"#{stat}1" unless stat==:cost
            (2..5).each do |num|
                t.integer   :"#{stat}#{num}"
            end
        end
      t.timestamps
    end
  end
end

class CreateLunaTics < ActiveRecord::Migration
  def change
    create_table :luna_tics do |t|

      t.timestamps
    end
  end
end

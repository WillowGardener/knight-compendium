class AddDeathToKnights < ActiveRecord::Migration
  def change
    add_column :knights, :dead, :boolean
  end
end

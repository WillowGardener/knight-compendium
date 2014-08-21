class AddKnightToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :knight, :string
  end
end

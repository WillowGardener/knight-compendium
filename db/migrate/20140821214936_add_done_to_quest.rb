class AddDoneToQuest < ActiveRecord::Migration
  def change
    add_column :quests, :done, :boolean
  end
end

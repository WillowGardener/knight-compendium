class AddDeadlineToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :deadline, :datetime
  end
end

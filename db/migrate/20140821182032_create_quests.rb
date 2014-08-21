class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end

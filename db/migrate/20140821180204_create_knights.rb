class CreateKnights < ActiveRecord::Migration
  def change
    create_table :knights do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end

class CreateFavoriteColors < ActiveRecord::Migration
  def change
    create_table :favorite_colors do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end

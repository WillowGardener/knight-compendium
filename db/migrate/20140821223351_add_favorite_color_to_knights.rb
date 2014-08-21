class AddFavoriteColorToKnights < ActiveRecord::Migration
  def change
    add_column :knights, :favorite_color, :string
  end
end

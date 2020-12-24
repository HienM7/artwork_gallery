class AnotherAddIdToFavorites < ActiveRecord::Migration[6.0]
  def change
    add_column :favorites, :id, :primary_key
  end
end

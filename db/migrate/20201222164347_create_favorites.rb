class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites, :id => false do |t|
      t.references :user, :artwork
      
      t.timestamps
    end

    add_index :favorites, [:user_id, :artwork_id],
      name: "users_artworks_index",
      unique: true
  end
end

class AddMoreFieldsToArtworks < ActiveRecord::Migration[6.0]
  def change
    add_column :artworks, :description, :string
    add_column :artworks, :download_link, :string
    add_column :artworks, :is_banned, :integer
  end
end

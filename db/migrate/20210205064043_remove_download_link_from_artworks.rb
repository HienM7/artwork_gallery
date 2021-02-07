class RemoveDownloadLinkFromArtworks < ActiveRecord::Migration[6.0]
  def change
    remove_column :artworks, :download_link, :string
  end
end

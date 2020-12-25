class AddUserIdToArtworks < ActiveRecord::Migration[6.0]
  def change
    add_reference :artworks, :user, null: false, foreign_key: true
  end
end

class CreateArtworks < ActiveRecord::Migration[6.0]
  def change
    create_table :artworks do |t|
      t.string :name
      t.string :img_link
      t.integer :value
      t.integer :is_public
      t.references :category

      t.timestamps
    end
  end
end

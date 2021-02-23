class AddDefaultValueToTimestamps < ActiveRecord::Migration[6.0]
  def up
    change_column_default :tags, :created_at, -> { 'NOW()' }
    change_column_default :tags, :updated_at, -> { 'NOW()' }
    change_column_default :taggings, :created_at, -> { 'NOW()' }
    change_column_default :taggings, :updated_at, -> { 'NOW()' }
  end

  def down
    change_column_default :tags, :created_at, nil
    change_column_default :tags, :updated_at, nil
    change_column_default :taggings, :created_at, nil
    change_column_default :taggings, :updated_at, nil
  end
end

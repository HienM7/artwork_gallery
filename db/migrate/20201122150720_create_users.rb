class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :credit_card
      t.boolean :is_admin, default: false
      t.boolean :is_banned, default: false
      t.integer :point, default: 0

      t.timestamps
    end
  end
end

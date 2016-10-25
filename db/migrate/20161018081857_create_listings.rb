class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.date :available_from, null: false
      t.date :available_until, null: false
      t.integer :price_day, null: false

      t.timestamps null: false
    end
  end
end

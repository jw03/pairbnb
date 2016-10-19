class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :address
      t.date :available_from
      t.date :available_until
      t.integer :price_day

      t.timestamps null: false
    end
  end
end

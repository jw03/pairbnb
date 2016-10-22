class CreateAvailableDates < ActiveRecord::Migration
  def change
    create_table :available_dates do |t|
      t.date :date
      t.boolean :availability, default: true
      t.integer :listing_id
      t.timestamps null: false
    end
  end
end

class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.timestamps null: false
    end
  end
end

class RemoveForeignKeyFromPlaces < ActiveRecord::Migration
  def change
    remove_foreign_key :events, :places
  end
end

class AddTrackNumToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :track_number, :integer
    change_column :tracks, :track_number, :integer, null: false

    add_index :tracks, [:album_id, :track_number], unique: true
  end
end

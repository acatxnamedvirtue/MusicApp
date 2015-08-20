class AddLyricsAndRemoveBandIdFromTracks < ActiveRecord::Migration
  def change
    remove_index :tracks, :band_id
    remove_column :tracks, :band_id
    add_column :tracks, :lyrics, :string
  end
end

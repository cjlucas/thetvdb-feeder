class AddSeriesEpisodesRelationship < ActiveRecord::Migration
  def change
    change_table :episodes do |t|
      t.integer :series_id
    end
  end
end

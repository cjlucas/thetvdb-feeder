class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :tvdb_id
      t.string :name
      t.integer :season_num
      t.string :episode_num
      t.datetime :airdate

      t.timestamps
    end
  end
end

class ChangeEpisodeAirdateField < ActiveRecord::Migration
  def change
    change_column :episodes, :airdate, :date
  end
end

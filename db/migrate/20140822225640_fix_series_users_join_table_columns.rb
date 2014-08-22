class FixSeriesUsersJoinTableColumns < ActiveRecord::Migration
  def change
    rename_column :series_users, :user_id_id, :user_id
    rename_column :series_users, :series_id_id, :series_id
  end
end

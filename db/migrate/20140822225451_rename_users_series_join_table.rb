class RenameUsersSeriesJoinTable < ActiveRecord::Migration
  def change
    rename_table :users_series, :series_users
  end
end

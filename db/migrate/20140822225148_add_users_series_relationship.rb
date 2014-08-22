class AddUsersSeriesRelationship < ActiveRecord::Migration
  def change
    create_table :users_series, id: false do |t|
      t.belongs_to :user_id
      t.belongs_to :series_id
    end
  end
end

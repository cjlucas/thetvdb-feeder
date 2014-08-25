class AddUserScannedAtField < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.timestamp :scanned_at
    end

    User.all.each { |user| user.scanned_at = user.updated_at; user.save }
  end
end

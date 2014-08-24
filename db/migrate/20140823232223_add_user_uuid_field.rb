class AddUserUuidField < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :uuid
    end

    User.all.each { |user| user.uuid = SecureRandom.uuid; user.save }
  end
end

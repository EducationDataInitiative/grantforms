class AddMygovUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mygov_uid, :string
  end
end

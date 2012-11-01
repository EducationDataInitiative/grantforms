class ChangeUsersIsadminToIsAdmin < ActiveRecord::Migration
  def change
    rename_column :users, :isadmin, :is_admin
  end
end

class AddMygovAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mygov_access_token, :string
  end
end

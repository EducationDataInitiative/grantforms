class CreateGrantApplications < ActiveRecord::Migration
  def change
    create_table :grant_applications do |t|
      t.references :grant
      t.references :organization
      t.references :user
      t.text :data

      t.timestamps
    end
    add_index :grant_applications, :grant_id
    add_index :grant_applications, :organization_id
    add_index :grant_applications, :user_id
  end
end

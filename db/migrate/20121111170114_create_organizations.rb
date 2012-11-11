class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :ein
      t.string :duns
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :province
      t.string :country, :default => 'USA'
      t.string :zip
      t.string :department_name
      t.string :division_name
      t.references :user

      t.timestamps
    end
  end
end

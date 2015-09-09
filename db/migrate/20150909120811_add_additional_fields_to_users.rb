class AddAdditionalFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    rename_column :users, :name, :last_name
    add_column :users, :gender, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
    add_column :users, :bio, :string
  end
end

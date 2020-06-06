class AddLastNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name, :string, null: false, default: ""
    add_column :users, :first_name, :string, null: false, default: ""
    add_column :users, :last_name_kana, :string, null: false, default: ""
    add_column :users, :first_name_kana, :string, null: false, default: ""
    add_column :users, :nickname, :string, null: false, default: ""
    add_column :users, :postcode, :string, null: false, default: ""
    add_column :users, :prefecture_code, :integer
    add_column :users, :address_city, :string
    add_column :users, :is_deleted, :boolean, null: false, default: true
    add_column :users, :profile_image_id, :string
    add_column :users, :address, :string, null: false, default: ""
  end
end

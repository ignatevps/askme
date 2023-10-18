class AddAvatarUrlToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :profile_color, :string
  end
end

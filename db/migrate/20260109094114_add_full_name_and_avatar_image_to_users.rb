class AddFullNameAndAvatarImageToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :avatar_image, :string
  end
end

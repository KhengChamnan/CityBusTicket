json.user do
  json.extract! @user, :id, :email_address, :credit, :full_name, :avatar_image
  # Add more user fields if needed:
  # json.extract! @user, :id, :email_address, :name, :created_at
end

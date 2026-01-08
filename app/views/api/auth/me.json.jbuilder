json.user do
  json.extract! @user, :id, :email_address
  # Add more user fields if needed:
  # json.extract! @user, :id, :email_address, :name, :created_at
end

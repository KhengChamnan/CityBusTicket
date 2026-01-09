json.message @message
json.token @token
json.user do
  json.extract! @user, :id, :email_address, :credit, :full_name, :avatar_image
end
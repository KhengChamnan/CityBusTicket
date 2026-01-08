json.message @message
json.token @token

json.user do
  json.extract! @user, :id, :email_address
end

json.meta do
  json.message "success"
  json.error "" 
end

json.data do
  json.id @user.id
  json.email @user.email
  json.full_name @user.fullname
  json.username @user.username
  json.birthday @user.birthday_format
  json.created_at @user.created_at_format
end
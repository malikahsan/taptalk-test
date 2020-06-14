json.meta do
  json.message "success"
  json.error ""
end

json.data do
  json.id @activity.id
  json.activity @activity.activity
  json.activity_at @activity._datetime_format
end
json.meta do
  json.message "success"
  json.error ""
end

json.data @daily_activities do |daily|
  json.id          daily.id
  json.activity    daily.activity
  json.activity_at daily._datetime_format
  json.updated_at  daily._datetime_format(scope: 'update')
end
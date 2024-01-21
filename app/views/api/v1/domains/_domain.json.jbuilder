json.id d.id
json.host d.host
json.created_at d.created_at
json.updated_at d.updated_at
json.user_id d.user_users_id
json.provisional d.provisional
json.plan d.plan
if records
  json.records d.records, partial: "/api/v1/domains/records/record", as: :r
end

json.id @id

if @name
  json.name @name
end

if @email
  json.email @email
end

if @admin
  json.admin @admin
end

json.verified @verified
json.created_at @created_at
json.updated_at @updated_at

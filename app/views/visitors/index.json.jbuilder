json.array!(@visitors) do |visitor|
  json.extract! visitor, :uuid
  json.url visitor_url(visitor, format: :json)
end
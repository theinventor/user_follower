json.array!(@tracks) do |track|
  json.extract! track, :visitor_id, :full_path, :referrer
  json.url track_url(track, format: :json)
end
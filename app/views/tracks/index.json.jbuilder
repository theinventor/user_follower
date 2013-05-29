json.array!(@tracks) do |track|
  json.extract! track, :visitor_id, :full_path, :referrer
end
json.extract! @visitor, :uuid, :created_at, :updated_at
json.tracks @visitor.tracks, :full_path, :referrer
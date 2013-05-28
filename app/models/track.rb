class Track < ActiveRecord::Base
  belongs_to :visitor

  def self.new_from_tracker params,uuid
    visitor = Visitor.find_or_create_by_uuid uuid
    new_track = self.new params
    new_track.visitor = visitor
    new_track
  end

end

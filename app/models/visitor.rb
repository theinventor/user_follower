class Visitor < ActiveRecord::Base
  has_many :tracks, :dependent => :destroy

  def self.generate_new ip_address
    #self.create uuid: SecureRandom.uuid
    self.create uuid: ip_address
  end
end

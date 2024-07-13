class Click < ApplicationRecord
  belongs_to :url

  before_create :set_geolocation

  attr_accessor :remote_ip  # Define an attribute accessor for remote_ip

  private

  def set_geolocation
    location = Geocoder.search(remote_ip).first
    self.geolocation = location.city if location
    self.clicked_at = Time.now
  end
end

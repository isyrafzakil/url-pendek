require 'rails_helper'

RSpec.describe Click, type: :model do
  describe "#set_geolocation" do
    let(:url) { Url.create!(long_url: "https://example.com", short_code: "abc123") }

    it "assigns geolocation if Geocoder returns a valid location" do
      click = Click.new(url: url, remote_ip: "127.0.0.1")
      allow(Geocoder).to receive(:search).and_return([double(city: "New York")])

      click.save!

      expect(click.geolocation).to eq("New York")
    end

    it "does not assign geolocation if Geocoder returns nil" do
      click = Click.new(url: url, remote_ip: "127.0.0.1")
      allow(Geocoder).to receive(:search).and_return([])

      click.save!

      expect(click.geolocation).to be_nil
    end

    it "assigns clicked_at with the current time" do
      click = Click.new(url: url, remote_ip: "127.0.0.1")
      allow(Geocoder).to receive(:search).and_return([double(city: "Chicago")])
      current_time = Time.now
      allow(Time).to receive(:now).and_return(current_time)

      click.save!

      expect(click.clicked_at).to eq(current_time)
    end
  end
end

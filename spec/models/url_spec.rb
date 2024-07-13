require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'UrlShortenerService' do
    it 'allows multiple short URLs for the same long URL' do
      long_url = "https://example.com"
      url1 = UrlShortenerService.new(long_url).call
      url2 = UrlShortenerService.new(long_url).call

      expect(url1.short_code).not_to eq(url2.short_code)
      expect(url1.long_url).to eq(url2.long_url)
    end
  end
end

require 'rails_helper'

RSpec.describe UrlShortenerService do
  describe '#call' do
    let(:long_url) { 'http://example.com' }
    let(:service) { UrlShortenerService.new(long_url) }
    let(:generated_short_code) { 'abc123' }
    
    it 'creates a new URL with correct long_url and short_code' do
      url_double = instance_double('Url', save: true, long_url: long_url, update: true)  
      
      allow(Url).to receive(:new).with(long_url: long_url, short_code: generated_short_code).and_return(url_double)
      allow(service).to receive(:generate_short_code).and_return(generated_short_code)
      
      expect(service.call).to eq(url_double)
    end

    it 'calls fetch_title when URL is saved successfully' do
      url_double = instance_double('Url', save: true, long_url: long_url, update: true) 
      
      allow(Url).to receive(:new).with(long_url: long_url, short_code: generated_short_code).and_return(url_double)
      allow(service).to receive(:generate_short_code).and_return(generated_short_code)

      expect(service).to receive(:fetch_title).with(url_double)
      service.call
    end

    it 'returns nil when URL fails to save' do
      url_double = instance_double('Url', save: false, long_url: long_url, update: true)  
      
      allow(Url).to receive(:new).with(long_url: long_url, short_code: generated_short_code).and_return(url_double)
      allow(service).to receive(:generate_short_code).and_return(generated_short_code)
      
      expect(service.call).to be_nil
    end
  end
end

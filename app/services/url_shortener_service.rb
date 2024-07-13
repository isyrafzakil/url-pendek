class UrlShortenerService
  attr_reader :errors
  def initialize(long_url)
    @long_url = long_url
    @errors = []
  end

  def call
    url = Url.new(long_url: @long_url, short_code: generate_short_code)
    if url.save
      fetch_title(url)
      url
    else
      nil
    end
  end

  private

  def generate_short_code
    loop do
      short_code = SecureRandom.urlsafe_base64(6)
      break short_code unless Url.exists?(short_code: short_code)
    end
  end

  def fetch_title(url)
    response = HTTParty.get(url.long_url)
    if response.code == 200
      title_tag = response.body.match(/<title>(.*?)<\/title>/)
      url.update(title: title_tag[1]) if title_tag
    end
  end
end

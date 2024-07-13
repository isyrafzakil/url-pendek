class Url < ApplicationRecord
    has_many :clicks, dependent: :destroy
  
    validates :long_url, presence: true, format: URI::regexp(%w[http https])
    validates :short_code, presence: true, uniqueness: true, length: { maximum: 15 }

    before_validation :assign_short_code, on: :create

    def assign_short_code
      self.short_code ||= SecureRandom.urlsafe_base64(6)
    end
  end
  

  
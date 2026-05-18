class Link < ApplicationRecord 
  belongs_to :linkable, polymorphic: true

  validates :title, presence: true
  validates :url, presence: true
  validate :check_url

  def check_url
    uri = URI.parse(url)

    unless uri&.host.present? || uri&.scheme || PublicSuffix.valid?(url, default_rule: nil)
      errors.add(:url, 'Check url')
    end
  rescue URI::InvalidURIError
    errors.add(:url, 'имеет некорректный формат')
  end

  def gist?
    uri = URI.parse(url) rescue false
    uri.host == 'gist.github.com'
  end

  def external_url
    url.start_with?('http://', 'https://') ? url : "https://#{url}"
  end
end

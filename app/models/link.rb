class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true

  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :url, format: { with: URL_REGEXP, message: "is invalid (format must be 'http(https)://google.com')" }

  def is_gist?
    url.include?("gist.github.com")
  end
end

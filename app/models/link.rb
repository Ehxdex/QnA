class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true

  validates_format_of :url, with: URI.regexp(%w[http https])

  def is_gist?
    url&.include?("gist.github.com")
  end
end

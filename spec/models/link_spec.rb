require 'rails_helper'

RSpec.describe Link, type: :model do
  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix

  it { should belong_to :linkable }
  it { should validate_presence_of :name }

  it { should validate_presence_of(:url).with_message("is invalid (format must be 'http(https)://google.com')") }

  it { should allow_value('https://foo.com', 'https://bar.com').for(:url) }
  it { should_not allow_values('https://googlecom', 'http///google.com', 'google.com', 'google').for(:url) }
end

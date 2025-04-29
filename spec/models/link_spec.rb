require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable }
  it { should validate_presence_of :name }

  it { should validate_presence_of(:url).with_message("is invalid") }

  it { should allow_value('https://foo.com', 'http://bar.com').for(:url) }
  it { should_not allow_values('googlecom', 'http///google.com', 'google.com', 'google').for(:url) }
end

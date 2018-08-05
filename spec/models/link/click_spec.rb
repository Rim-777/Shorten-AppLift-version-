require 'rails_helper'

RSpec.describe Link::Click, type: :model do
  it { should belong_to(:link) }
end

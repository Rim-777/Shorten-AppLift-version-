require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should have_many(:clicks).class_name('Link::Click').dependent(:destroy) }
end

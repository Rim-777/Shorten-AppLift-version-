class Link::Click < ApplicationRecord
  belongs_to :link, inverse_of: :clicks
end

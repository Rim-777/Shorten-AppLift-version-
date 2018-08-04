class Link < ApplicationRecord
  validates :url, presence: true
  before_validation :set_shortcode
  has_many :clicks, class_name: 'Link::Click', dependent: :destroy , inverse_of: :link

  def self.new_shortcode
    loop do
      shortcode = ShortcodeGenerator.generate(6)
      return shortcode unless self.find_by_shortcode(shortcode)
    end
  end

  def add_click
    clicks.create
  end

  private
  def set_shortcode
    self.shortcode = self.class.new_shortcode
  end
end

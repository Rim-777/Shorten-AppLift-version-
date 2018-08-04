class Link < ApplicationRecord
  validates :url, presence: true
  before_validation :set_shortcode
  has_many :clicks, class_name: 'Link::Click', dependent: :destroy, inverse_of: :link

  def stats(**options)
    start_time = options[:start_time].try(:to_datetime)
    end_time = options[:end_time].try(:to_datetime) || DateTime.now
    if start_time.present?
      clicks.where('created_at >= ? AND created_at < ?', start_time, end_time).count
    else
      clicks.count
    end
  end

  private

  def set_shortcode
    self.shortcode = new_shortcode
  end

  def new_shortcode
    loop do
      code = ShortcodeGenerator.generate(6)
      return code unless self.class.find_by_shortcode(code)
    end
  end
end

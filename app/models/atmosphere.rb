class Atmosphere < ActiveRecord::Base
  include Labelized
  
  has_many :opuses

  validates :color, css_hex_color: true

  def text_color
    darken_color(color, 0.55)
  end

  private

  # Amount should be a decimal between 0 and 1. Lower means darker
  def darken_color(hex_color, amount=0.4)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] = (rgb[0].to_i * amount).round
    rgb[1] = (rgb[1].to_i * amount).round
    rgb[2] = (rgb[2].to_i * amount).round
    "#%02x%02x%02x" % rgb
  end
end

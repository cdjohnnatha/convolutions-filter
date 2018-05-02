require "convolutions/filter/version"
require 'rmagick'

module Convolutions
  module Filter
    img = Magick::Image::read("data/lena.png");
    img.display
    exit
  end
end

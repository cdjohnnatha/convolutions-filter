require "convolutions/filter/version"
require 'rmagick'
require "convolutions/filter/convolution"

module Convolutions
  module Filter
    img = Magick::Image::read("data/lena.png")[0];
    convolution = Convolution.new(img)
  end
end

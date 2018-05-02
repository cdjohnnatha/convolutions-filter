require 'rmagick'
require_relative 'sharpness'
require_relative 'corner'
require_relative 'emboss'

module Convolutions
  module Filter
    class Convolution
      attr_accessor :image  

      def initialize(img)
        @image = img.clone
        imageSecond = img.clone
        sharpness = Sharpness.new
        corner = Corner.new
        sharpnessArr = Array.new
        image.each_pixel do |pixel, column, row|
          sharpnessArr << convolution(pixel, column, row, sharpness.filter_b)
        end

        imageSecond.store_pixels(0, 0, 512, 512, sharpnessArr)
        # # image.display
        imageSecond.display
      end

      def convolution(pixel, column, row, filter)
        offset = filter.size / 2
        r, g, b = 0.0, 0.0, 0.0

        (0..2).each do |i|
          (0..2).each do |j|
            r += (pixel.red.to_f/256 ) * filter[i][j]
            g += (pixel.green.to_f/256) * filter[i][j]
            b += (pixel.blue.to_f/256) * filter[i][j]
          end
        end

        tmp_pixel = Magick::Pixel.new(r, g, b)
      end
    end
  end
end

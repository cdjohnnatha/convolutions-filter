require 'rmagick'
require_relative 'sharpness'
require_relative 'corner'
require_relative 'emboss'
require_relative 'matrix_util'

module Convolutions
  module Filter
    class Convolution
      attr_accessor :image

      def initialize(img)
        @image = img.clone
        @image.display
        sharpness_filter_a_image = img.clone
        sharpness_filter_b_image = img.clone
        corner_filter_a_image = img.clone
        corner_filter_b_image = img.clone
        corner_filter_c_image = img.clone
        corner_filter_d_image = img.clone
        emboss_filter_a_image = img.clone
        emboss_filter_b_image = img.clone
        emboss_filter_c_image = img.clone
        
        sharpness = Sharpness.new(10, 15)
        corner = Corner.new
        emboss = Emboss.new

        sharpness_filter_a = Array.new
        sharpness_filter_b = Array.new
        corner_filter_a = Array.new
        corner_filter_b = Array.new
        corner_filter_c = Array.new
        corner_filter_d = Array.new
        emboss_filter_a = Array.new
        emboss_filter_b = Array.new
        emboss_filter_c = Array.new
        max_util = MatrixUtil.new
        puts "#{sharpness.filter_a}"
        puts "#{sharpness.filter_b}"
        image.each_pixel do |pixel, column, row|
          sharpness_filter_a << convolution(pixel, max_util.rotate180(sharpness.filter_a)) 
          sharpness_filter_b << convolution(pixel, max_util.rotate180(sharpness.filter_b)) 
          
          # corner_filter_a << convolution(pixel, max_util.rotate180(corner.filter_a)) 
          # corner_filter_b << convolution(pixel, max_util.rotate180(corner.filter_b)) 
          # corner_filter_c << convolution(pixel, max_util.rotate180(corner.filter_c))
          # corner_filter_d << convolution(pixel, max_util.rotate180(corner.filter_d))
          
          # emboss_filter_a << convolution(pixel, max_util.rotate180(emboss.filter_a)) 
          # emboss_filter_b << convolution(pixel, max_util.rotate180(emboss.filter_b))
          # emboss_filter_c << convolution(pixel, max_util.rotate180(emboss.filter_c)) 
        end
        
        sharpness_filter_a_image.store_pixels(0, 0, 512, 512, sharpness_filter_a)
        sharpness_filter_b_image.store_pixels(0, 0, 512, 512, sharpness_filter_b)
        
        # corner_filter_a_image.store_pixels(0, 0, 512, 512, corner_filter_a)
        # corner_filter_b_image.store_pixels(0, 0, 512, 512, corner_filter_b)
        # corner_filter_c_image.store_pixels(0, 0, 512, 512, corner_filter_c)
        # corner_filter_d_image.store_pixels(0, 0, 512, 512, corner_filter_d)

        # emboss_filter_a_image.store_pixels(0, 0, 512, 512, emboss_filter_a)
        # emboss_filter_b_image.store_pixels(0, 0, 512, 512, emboss_filter_b)
        # emboss_filter_c_image.store_pixels(0, 0, 512, 512, emboss_filter_c)
        
        sharpness_filter_a_image.display
        sharpness_filter_b_image.display
        
        # corner_filter_a_image.display
        # corner_filter_b_image.display
        # corner_filter_c_image.display
        # corner_filter_d_image.display
        # emboss_filter_a_image.display
        # emboss_filter_b_image.display
        # emboss_filter_c_image.display
      end

      def convolution(pixel, filter)
        rloc=0
        gloc=0
        bloc=0
        red = (pixel.red.to_f)/256
        green = (pixel.green.to_f)/256
        blue = (pixel.blue.to_f)/256
        # puts "INIT LOOP"
        for i in 0..2 do
          # puts "-------------------------------"
          for j in 0..2 do
            # puts "<<<<<<< #{i}, #{j} >>>>>>>>"
            # puts "#{rloc}, #{gloc}, #{bloc}<<<<<<<"
            # puts "RLOC: #{rloc}"
            # puts "RED: #{red * filter[i][j]}"
            # puts "BLOC: #{bloc}"
            # puts "BLUE: #{blue * filter[i][j]}"
            # puts "GLOC: #{gloc}"
            # puts "GREE: #{green * filter[i][j]}"
            rloc += red * filter[i][j]
            gloc += green * filter[i][j]
            bloc += blue * filter[i][j]
            # puts "---RESULT #{rloc}, #{gloc}, #{bloc}"
          end
          # puts "#{rloc}, #{gloc}, #{bloc} #{i} >>>>>>>"
        end
        # puts "#{rloc}, #{gloc}, #{bloc} >>>>><<<<<<"
        # puts "#{filter}"

        if rloc > 255
         rloc = 255
        elsif rloc < 0
         rloc = 0  
        end

        if gloc > 255
         gloc = 255
        elsif gloc < 0
         gloc = 0  
        end

        if bloc > 255
         bloc = 255
        elsif bloc < 0
         bloc = 0  
        end

        rloc *= 256
        gloc *= 256
        bloc *= 256

        tmp_pixel = Magick::Pixel.new(rloc, gloc, bloc)
      end
    end
  end
end

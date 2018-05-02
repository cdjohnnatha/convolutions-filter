require 'matrix'

module Convolutions
  module Filter
    class Sharpness
      attr_accessor :filter_a, :filter_b, :c, :d 

      def initialize(c=1, d=1)
        @c, @d = c, d
        @filter_a = Matrix.build(3) { 0 }.to_a
        @filter_a[0][1] = -c
        @filter_a[1][0] = -c
        @filter_a[1][1] = 4*c + d
        @filter_a[1][2] = -c
        @filter_a[2][1] = -c
        @filter_b = Matrix.build(3) { -@c }.to_a
        @filter_b[1][1] = 8*c + d
      end
    end
  end
end

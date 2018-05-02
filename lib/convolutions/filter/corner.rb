require 'matrix'

module Convolutions
  module Filter
    class Corner
      attr_accessor :filter_a, :filter_b, :filter_c, :filter_d

      def initialize(c=1, d=1)
        @c, @d = c, d
        
        @filter_a = Matrix.build(3) { -0.125 }.to_a
        @filter_b = Matrix.build(3) { 0 }.to_a
        @filter_c = Matrix.build(3) { 0 }.to_a
        @filter_d = Matrix.build(3) { 0 }.to_a

        @filter_a[1][1] = 1
        @filter_b[0][0], @filter_b[0][1], @filter_b[0][1] = -1, -1, -1 
        @filter_b[2][0], @filter_b[2][1], @filter_b[2][1] = 1, 1, 1 
        @filter_c[0][0], @filter_c[1][0], @filter_c[2][0] = -1, -1, -1
        @filter_c[0][2], @filter_c[1][2], @filter_c[2][2] = 1, 1, 1
        @filter_d[0][0], @filter_d[0][1], @filter_d[1][0] = -1, -1, -1
        @filter_d[1][2], @filter_d[2][1], @filter_d[2][2] = 1, 1, 1
      end
    end
  end
end

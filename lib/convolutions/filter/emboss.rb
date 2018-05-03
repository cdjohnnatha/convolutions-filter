module Convolutions
  module Filter
    class Emboss
      attr_accessor :filter_a, :filter_b, :filter_c

      def initialize
        @filter_a = Matrix.build(3) { 0 }.to_a
        @filter_b = Matrix.build(3) { 0 }.to_a
        @filter_c = Matrix.build(3) { 0 }.to_a

        @filter_a[1][1] = 1
        @filter_a[2][2] = -1

        @filter_b[0][2] = -1
        @filter_b[1][1] = 1

        @filter_c[1][1], @filter_c[2][0] = -1
        @filter_c[0][2] = 2
      end
    end
  end
end

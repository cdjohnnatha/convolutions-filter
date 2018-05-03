
module Convolutions
  module Filter
    class MatrixUtil
      #It will rotate by 90º and 90º
      def rotate180(arr)
        tmp = arr.transpose.map &:reverse
        tmp = tmp.transpose.map &:reverse
        tmp
      end
    end
  end
end

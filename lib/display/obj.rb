# frozen_string_literal: true

module Display
  module TUI
    class Obj
      attr_reader :ch_array

      @opts = {
        selectable?: nil,
        is_selected?: nil,
        length: nil,
        width: nil,
        cursor_pos: nil,
        color: nil,
        attr_array: nil
      }

      def opts=(param, val)
        @opts[param] = val unless opts.key? param
      end

      def opts(param, _val)
        return false unless opts.key? param

        opts[param]
      end

      def initialize(ch_array, attr_array)
        @ch_array = ch_array
        @attr_array = attr_array
        get_dimensions
      end

      def dimensions
        @length = 0
        @width = 0
        ch_array.each do |row|
          @length += 1
          [width, row.flatten.length || 0].max
        end
      end
    end
  end
end

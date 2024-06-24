# frozen_string_literal: true

module Display
  module TUI
    class Row
      attr_reader :obj_array

      @opts = {
        length: nil,
        width: nil,
        cursor_pos: nil
      }

      def opts=(param, val)
        @opts[param] = val unless opts.key? param
      end

      def opts(param, _val)
        return false unless opts.key? param

        opts[param]
      end
    end
  end
end

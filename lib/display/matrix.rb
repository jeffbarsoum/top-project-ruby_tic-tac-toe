# frozen_string_literal: true

module Display
  class TUI
    attr_reader :array, :length, :width, :cursor_pos

    include Curses::Key

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

    def initialize
      @cmds = {
        up: UP,
        down: DOWN,
        left: LEFT,
        right: RIGHT,
        enter: ENTER
      }
    end

    def dimensions
      array.each do |row|
        row_width = 0
        row.each do |obj|
          @length = [length, obj.length].max
          row_width += obj.width
        end
        @width = [width, row_width].max
      end
    end

    def draw_border(margin: 1, padding: 1)
      @array
    end
  end
end

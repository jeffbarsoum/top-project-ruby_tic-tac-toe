# frozen_string_literal: true

require 'curses'

module Display
  module TUI
    class Mouse
      attr_reader :pos_hash, :curs_timeout

      include Curses

      @positions = []

      def initialize
        @curs_timeout = 1
        # Switch on mouse continous position reporting
        print("\x1b[?1003h")

        # Also enable SGR extended reporting, because otherwise we can only
        # receive values up to 160x94. Everything else confuses Ruby Curses.
        print("\x1b[?1006h")
      end

      def draw_cursor(y, x)
        # Keep a trail of 3 previous positions visible on the screen
        if @positions.size >= 3
          pos_old = @positions.shift
          setpos pos_old[:pos][:y], pos_old[:pos][:x]
          addch pos_old[:pixel]
        end

        for i in 0..positions.length - 1 do
          break if positions[i][:timestamp] <= Time.now - timeout

          pos_old = @positions.shift
          setpos pos_old[:pos][:y], pos_old[:pos][:x]
          addch pos_old[:pixel]
        end

        setpos y, x
        pos_hash = {
          pos: {
            y: y,
            x: x
          },
          pixel: inch,
          timestamp: Time.now
        }
        addstr '<'
        @positions << pos_hash
      end

      def curr_pos
        positions[-1][:pos]
      end
    end
  end
end

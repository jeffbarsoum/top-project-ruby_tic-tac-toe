class Display::TUI:Matrix
  attr_reader :array, :length, :width, :cursor_pos
  include Curses::Key

  @opts = {
    length: nil,
    width: nil,
    cursor_pos: nil,
  }

  def opts=param, val
    return false unless self.opts.key? param
    @opts[param] = val
  end

  def opts param, val
    return false unless self.opts.key? param
    self.opts[param]
  end

  def initialize
    @cmds = {
      up: UP,
      down: DOWN,
      left: LEFT,
      right: RIGHT,
      enter: ENTER
    }

  def get_dimensions
    array.each do |row|
      row_width = 0
      row.each do |obj|
        @length = [self.length, obj.length].max
        row_width += obj.width
      end
      @width = [self.width, row_width].max
    end
  end

  def draw_border margin: 1, padding: 1
    @array.each |


end

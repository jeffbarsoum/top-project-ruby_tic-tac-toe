class Display::TUI::Obj
  attr_reader :ch_array, :opts

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
    return false unless opts.key? param

    @opts[param] = val
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

  def get_dimensions
    @length = 0
    @width = 0
    ch_array.each do |row|
      length += 1
      width = [width, row.flatten.length || 0].max
    end
  end
end

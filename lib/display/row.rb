class Display::TUI::Row
  attr_reader :obj_array, :opts

  @opts = {
    length: nil,
    width: nil,
    cursor_pos: nil
  }

  def opts=param, val
    return false unless self.opts.key? param
    @opts[param] = val
  end

  def opts param, val
    return false unless self.opts.key? param
    self.opts[param]
  end

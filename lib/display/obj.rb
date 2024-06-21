class Display::TUI::Obj

  attr_reader :ch_array, :attr_array, :length, :width

  def initialize ch_array, attr_array
    @ch_array = ch_array
    @attr_array = attr_array
    self.get_dimensions
  end

  def get_dimensions
    @length = 0
    @width = 0
    self.ch_array.each do |row|
      length += 1
      width = [width, row.flatten.length || 0].max
    end
  end

end

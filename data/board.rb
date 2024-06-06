module DataBoard

  def square_size
    [3, 5]
  end

  def default_board_size
    3
  end

  def max_board_size
    7
  end

  def border
    {
      top: "_",
      side: "|",
      bottom: "-",
      corner: "+"
    }
  end

  def square_choices
    [:x, :o, :nil]
  end

end

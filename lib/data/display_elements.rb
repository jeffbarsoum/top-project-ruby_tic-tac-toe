class DisplayElements

  def borders
    {
      vertical: {
        light: "\u2502",
        light_2dash: "\u254e",
        light_3dash: "\u2506",
        light_4dash: "\u250a",
        heavy: "\u2503",
        heavy_2dash: "\u254f",
        heavy_3dash: "\u2507",
        heavy_4dash: "\u250b"
      },
      horizontal: {
        light: "\u2500",
        light_2dash: "\u254c",
        light_3dash: "\u2504",
        light_4dash: "\u2508",
        heavy: "\u2501",
        heavy_2dash: "\u254d",
        heavy_3dash: "\u2505",
        heavy_4dash: "\u2509"
      },
      top_left_corner: {
        light: "\u250c",
        heavy: "\u250f",
        heavy_light_dn: "\u250d",
        heavy_light_rt: "\u250e",
        double: "\u2554",
        double_single_dn: "\u2552",
        double_single_rt: "\u2553",
        rounded: "\u256d"
      },
      top_right_corner: {
        light: "\u2510",
        heavy: "\u2513",
        heavy_light_dn: "\u2511",
        heavy_light_lt: "\u2512",
        double: "\u2557",
        double_single_dn: "\u2555",
        double_single_lt: "\u2556",
        rounded: "\u256e"
      },
      bottom_left_corner: {
        light: "\u2514",
        heavy: "\u2517",
        heavy_light_up: "\u2515",
        heavy_light_rt: "\u2516",
        double: "\u255a",
        double_single_up: "\u2558",
        double_single_rt: "\u2559",
        rounded: "\u2570"
      },
      bottom_right_corner: {
        light: "\u2518",
        heavy: "\u251b",
        heavy_light_up: "\u2519",
        heavy_light_lt: "\u251a",
        double: "\u255d",
        double_single_up: "\u255b",
        double_single_lt: "\u256c",
        rounded: "\u256f"
      },
      right_diagonal: "\u2571",
      left_diagonal: "\u2572",
      cross_diagonal: "\u2572"
    }
  end

  def box side, style = :light, element = nil
    return borders[side] unless borders[side].is_a? Hash
    return borders[side][style] unless element
    return borders[side][:"#{style}_#{element}"]
  end

  def draw_x size = 2
    sq_pixels = (size - 1) * 2 + 1
    ch_array = []
    sq_pixels.times do |row|
      ch_array << []
      sq_pixels.times do |col|
        is_center = row == col && row / (sq_pixels + 1) == 0.5
        is_left_diag = row == col && !is_center
        is_right_diag = 
        ch_array[row] << nil
      end
    end

    return [
      []
    ]
  end

  def draw_border array, style = :light, element = nil

  end

end

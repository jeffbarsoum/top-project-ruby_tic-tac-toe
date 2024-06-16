require "get_user_input"

module Display

  include Error
  include GetUserInput


  def screen display:, state_hash:, state_cmds: [], screen_cmds: [], **opts
    vertical = opts[:vertical] || false
    input? = opts[:input?] || true
    any_text? = opts[:any_text?] || false
    timeout = opts[:timeout] || 1

    self.clear_screen
    if input?
      screen_str = display + self.opts_display state_hash, vertical
      user_input_opts = {
        message: screen_str,
        multi_entry: false,
        user_options: state_cmds + screen_cmds,
        any_text?: any_text?
      }
      self.return_user_input user_input_opts
    else
      puts display
      sleep timeout
    end
  end

  def opts_display state_hash, vertical = false
    spacing = vertical ? "\n" : " | "
    return_string = self.print_spacing
    # concatenate all options in a given hash
    return_string += state_hash.reduce return_string do |display, (cmd, hash)|
      display += "#{hash[:text]}: #{hash[:user_input]}#{spacing}"
      display
    end
    return_string += self.print_spacing
  end

  def print_spacing
    "\n\nXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOn\n"
  end

  def clear_screen
    system "clear" || system "cls"
  end

end

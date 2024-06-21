class Display::TUI
  include Curses

  def initialize
    init_screen
    start_color
    curs_set 0
    noecho
    init_pair 1, 1, 0
  end

  def screen
    begin
      win = Curses::Window.new 0, 0, 1, 2

      loop do
        # Screen logic here
        # Draw screen and selected
        # Get user input
        #   - arrow keys change selected tile
        #   - enter selects tile and processes user input
        #   - hightligt characters associated with select tile
        #   - each user input should launch a new state, generate a new screen
        # Need a function to determine what's selected, based on key press
        # Going to need a simplified matrix of data to check what's selected where
      end
    ensure
      close_screen
    end
  end

end

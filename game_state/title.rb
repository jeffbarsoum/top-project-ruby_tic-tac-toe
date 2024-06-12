require "game_state"
require "players"

class Title < GameState

  def state_opts param = nil
    super param
  end

  def state_opts=param, value
    super param, value
  end

  def get_next_state
    super
  end

  def game_save
    super
  end



  def initialize
    self.state_opts = "state_cmds", {
      o: {
        state: "start",
        text: "Start"
      },
      l: {
        state: "load",
        text: "Load"
      }
      s: {
        state: "save",
        text: "Save"
      },
      q: {
        state: "quit",
        text: "Quit"
      }
    }
    self.state_opts = "vertical", true
    self.state_opts = "input?", false
    self.state_opts = "any_text?", false

    self.state_opts = "screen", self.display
    super opts
  end

  def display
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    Please press a key to choose your option:

    STRING
  end

  def start


    opts_input = self.data.generate_opts "input", opts
    opts_message = self.data.generate_opts "message", opts

    # Get player names from user and set up player objects
    until Player.get_free_players.empty? do
      args[:msg] = "What would you like us to call you this round?"
      input_state = self.fsm.load_next_state "input", args, opts[:state_cmds], opts[:screen_cmds]
      player = Player.new input_state.user_input
      args[:msg] = "Hello, #{player.name}, you will be '#{player}''s"
      message_state = self.fsm.load_next_state "message", args, opts[:state_cmds], opts[:screen_cmds]
    end

    # get board size
    args[:msg] <<-STRING
    How big do you want the Tic Tac Toe Board to be?

      The default is 3, so 3 rows and 3 columns, and 3
      in a row wins

      You can go as high as 7:
    STRING
    input_state = fsm.load_next_state "input", args, opts[:state_cmds], opts[:screen_cmds]
    board_size = input_state.user_input
  end

  def load

  end

  def save

  end

  def quit

  end

  def load_board_size
    msg <<-STRING
    How big do you want the Tic Tac Toe Board to be?

      The default is 3, so 3 rows and 3 columns, and 3
      in a row wins

      You can go as high as 7:
    STRING
    input_state = self.input msg
    @game_opts[:board_size] = input_state.user_input
  end

end

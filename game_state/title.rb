require "game_state"
require "player"

class Title < GameState

  attr_reader :cmd


  def state_opts param = nil
    super param
  end

  def state_opts=param, value
    super param, value
  end

  def run_cmd opts
    super opts
  end


  def initialize **opts
    super opts
  end

  def display _args = {}
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

end

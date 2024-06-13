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
      p: {
        state: :play,
        text: "Start"
      },
      l: {
        state: :load,
        text: "Load"
      }
      q: {
        state: :quit,
        text: "Quit"
      }
    }
    self.state_opts = :vertical, true
    self.state_opts = :input?, false
    self.state_opts = :any_text?, false

    self.state_opts = :screen, self.display
    super
  end

  def display
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    Please press a key to choose your option:

    STRING
  end

end

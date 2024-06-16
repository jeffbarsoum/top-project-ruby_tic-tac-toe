require "state"

class State::Win < State

  attr_reader :cmd


  def opts param = nil
    super param
  end

  def opts=param, value
    super param, value
  end

  def run_cmd opts
    super opts
  end


  def initialize **opts
    super opts
  end

  def display player
    player_win_msg = "*** #{player.name} Wins!! Ballin... ***"
    player_win_msg += player_win_msg.length % 2 == 0 ? "" : " "
    spacing_length = ((38 - player_win_msg.length) / 2).to_i
    spacing = Array.new(spacing_length, " ").join
    player_name = "#spacing"
    #banner contains 2 rows and 38 characters each
    #art borrowed from the below websites:
    # https://www.angelfire.com/ca/mathcool/4july.html
    # http://www.ae.metu.edu.tr/~cengiz/airplane-ascii.html

    msg_win <<-STRING
                                   ______________________________________
                  , _.o..__  / \  /      *** BREAKING NEWS!!! ***        |
                  +********=++-'-- #{spacing}#{player_win_msg}#{spacing} |
                  ` o/            \______________________________________|



                  .''.
                  .''.      .        *''*    :_\/_:     .
                :_\/_:   _\(/_  .:.*_\/_*   : /\ :  .'.:.'.
              .''.: /\ :    /)\   ':'* /\ *  : '..'.  -=:o:=-
              :_\/_:'.:::.  | ' *''*    * '.\'/.'_\(/_ '.':'.'
              : /\ : :::::  =  *_\/_*     -= o =- /)\     '  *
              '..'  ':::' === * /\ *     .'/.\'.  ' ._____
                *        |   *..*         :       |.   |' .---"|
                  *      |     _           .--'|  ||   | _|    |
                  *      |  .-'|       __  |   |  |    ||      |
                .-----.   |  |' |  ||  |  | |   |  |    ||      |
              ___'       ' /"\ |  '-."".    '-'   '-.'    '`      |____
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                  ~-~-~-~-~-~-~-~-~-~      /|
                    )      ~-~-~-~-~-~-~-~      /|~       /_|\
                  _-H-__  -~-~-~-~-~-~         /_|\    -~======-~
              ~-\XXXXXXXXXX/~     ~-~-~-~     /__|_\ ~-~-~-~
              ~-~-~-~-~-~    ~-~~-~-~-~-~    ========  ~-~-~-~
                ~-~~-~-~-~-~-~-~-~-~-~-~-~ ~-~~-~-~-~-~
                                  ~-~~-~-~-~-~

XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

Thanks for playing! What would you like to do?

XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
  end

  def play_again

  end

  def save

  end

  def quit

  end

end
